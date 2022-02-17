import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Create storage
  final storage = const FlutterSecureStorage();
  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;

        saveUid(user!.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
          Get.snackbar("Error", e.message.toString());
        } else if (e.code == 'invalid-credential') {
          Get.snackbar("Error", e.message.toString());
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
        // ...
      }
    }
    return user;
  }

  Future<User?> createUserWithEmailAndPassword(
      String yourEmail, String yourPassword) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: yourEmail, password: yourPassword);
      user = userCredential.user;
      saveUid(user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Lỗi", "Tài khoản đã tồn tại");
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Đã có lỗi xảy ra");
    }

    return user;
  }

  Future<void> saveUid(String uid) async {
    await storage.write(key: "uid", value: uid);
  }

  Future<String?> getUid() async {
    return await storage.read(key: "uid");
  }

  Future<void> deleteUid(String key) async {
    await storage.delete(key: key);
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    deleteUid("uid");
  }
}
