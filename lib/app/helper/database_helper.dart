import 'all_imports.dart';

class DatabaseHelper {
  static Future createUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data["email"], password: data["password"]);
      data.addEntries({"uid": user.user!.uid}.entries);
      await FirebaseFirestore.instance
          .collection("consumers")
          .doc(data["uid"])
          .set(data);
      writeUserDetails(data);
      return user.user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }
}
