import 'all_imports.dart';

class DatabaseHelper {
  static Future createUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data["email"], password: data["password"]);

      data.addEntries({"uid": user.user!.uid}.entries);
      await FirebaseFirestore.instance
          .collection(
              data["userType"] == AppStrings.farmer ? "farmers" : "consumers")
          .doc(data["uid"])
          .set(data);
      writeUserDetails(data);
      return user.user;
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
}
