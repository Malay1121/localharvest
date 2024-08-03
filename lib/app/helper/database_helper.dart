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
}
