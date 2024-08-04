import 'all_imports.dart';

class DatabaseHelper {
  static Future getApis() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("api_key")
          .doc("api_key")
          .get();
      apiKeys = documentSnapshot.data() as Map;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future uploadFile({required String path, required File file}) async {
    Reference reference = storage.ref().child(path);
    await reference.putFile(file);
    String location = await reference.getDownloadURL();
    return location;
  }

  static Future createUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data["email"], password: data["password"]);
      String type = (data["profilePicture"] as File).path.split(".").last;
      String profilePicture = await uploadFile(
          path:
              "${data["userType"] == AppStrings.farmer ? "farmers" : "consumers"}/${user.user!.uid}.${type}",
          file: data["profilePicture"]);
      data["profilePicture"] = profilePicture;

      data.addEntries({"uid": user.user!.uid}.entries);
      await FirebaseFirestore.instance
          .collection(
              data["userType"] == AppStrings.farmer ? "farmers" : "consumers")
          .doc(data["uid"])
          .set(data);
      writeUserDetails(data);
      return user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future? loginUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data["email"], password: data["password"]);
      Map<String, dynamic>? userData = (await FirebaseFirestore.instance
              .collection(data["userType"] == AppStrings.farmer
                  ? "farmers"
                  : "consumers")
              .doc(user.user!.uid)
              .get())
          .data();
      if (userData != null) writeUserDetails(userData);
      return user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future<List<Map>> getProducts({String? farmerId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = farmerId != null
          ? await FirebaseFirestore.instance
              .collection("products")
              .where("farmerId", isEqualTo: farmerId)
              .get()
          : await FirebaseFirestore.instance.collection("products").get();
      List<Map> docs = [];
      for (var doc in querySnapshot.docs) {
        Map docData = doc.data();
        DocumentSnapshot<Map<String, dynamic>> farmerSnapshot =
            await FirebaseFirestore.instance
                .collection("farmers")
                .doc(docData["farmerId"])
                .get();
        docData.addEntries({"farmerDetails": farmerSnapshot.data()}.entries);
        docs.add(docData);
      }
      return docs;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return [];
  }

  static Future<List<Map>> getFarmers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("farmers").get();
      List<Map> docs = [];
      for (var doc in querySnapshot.docs) {
        Map docData = doc.data();
        docs.add(docData);
      }
      return docs;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return [];
  }

  static Future<Map> getProduct({required String id}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("products").doc(id).get();
      Map docData = querySnapshot.data() ?? {};
      DocumentSnapshot<Map<String, dynamic>> farmerSnapshot =
          await FirebaseFirestore.instance
              .collection("farmers")
              .doc(docData["farmerId"])
              .get();
      docData.addEntries({"farmerDetails": farmerSnapshot.data()}.entries);
      return docData;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return {};
  }

  static Future<Map<String, dynamic>> getConsumer({required String id}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("consumers")
              .doc(id)
              .get();

      return querySnapshot.data() ?? {};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return {};
  }

  static Future createProduct({required Map<String, dynamic> data}) async {
    try {
      Map<String, dynamic> userDetails = await readUserDetails() ?? {};
      String type = (data["image"] as File).path.split(".").last;
      String productImage = await uploadFile(
          path:
              "products/${userDetails["uid"]}${DateTime.now().toUtc().millisecondsSinceEpoch}.${type}",
          file: data["image"]);
      data["image"] = productImage;
      DocumentReference doc =
          await FirebaseFirestore.instance.collection("products").add(data);
      await FirebaseFirestore.instance
          .collection("products")
          .doc(doc.id)
          .update({"id": doc.id});
      return true;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future editProduct({required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(data["id"])
          .update(data);
      return true;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future<List<Map>> getCart({required String uid}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("consumers")
              .doc(uid)
              .collection("cart")
              .get();
      List<Map> docs = [];
      for (var doc in querySnapshot.docs) {
        Map docData = doc.data();

        Map productDetails = await getProduct(id: docData["id"]);
        docData.addEntries({"productDetails": productDetails}.entries);
        docs.add(docData);
      }
      return docs;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return [];
  }

  static Future addToCart(
      {required String uid,
      required String productId,
      required int quantity}) async {
    try {
      await FirebaseFirestore.instance
          .collection("consumers")
          .doc(uid)
          .collection("cart")
          .doc(productId)
          .set({"id": productId, "quantity": quantity});

      return true;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return [];
  }

  static Future checkout(
      {required String uid, required List<Map> products}) async {
    try {
      for (Map product in products) {
        await FirebaseFirestore.instance
            .collection("consumers")
            .doc(uid)
            .collection("cart")
            .doc(product["id"])
            .delete();
        await FirebaseFirestore.instance
            .collection("farmers")
            .doc(product["productDetails"]["farmerDetails"]["uid"])
            .collection("orders")
            .doc(product["id"] + uid)
            .set({
          "productId": product["id"],
          "id": product["id"] + uid,
          "consumerId": uid,
          "quantity": product["quantity"],
        });
      }

      return true;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return [];
  }

  static Future<List<Map>> getOrders({required String uid}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("farmers")
              .doc(uid)
              .collection("orders")
              .get();
      List<Map> docs = [];
      for (var doc in querySnapshot.docs) {
        Map docData = doc.data();

        Map productDetails = await getProduct(id: docData["productId"]);
        docData.addEntries({"productDetails": productDetails}.entries);
        Map consumerDetails = await getConsumer(id: docData["consumerId"]);
        docData.addEntries({"consumerDetails": consumerDetails}.entries);
        docs.add(docData);
      }
      return docs;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
    return [];
  }

  static Future<int?> getOrdersCount({required String uid}) async {
    try {
      AggregateQuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("farmers")
          .doc(uid)
          .collection("orders")
          .count()
          .get();

      return querySnapshot.count ?? 0;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }
}
