import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';

class AuthService {
  // Create storage
  final storage = const FlutterSecureStorage();
  final userRepository = Get.find<UserRepository>();
  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      EasyLoading.show(status: "please_wait".tr);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;

        if (userCredential.additionalUserInfo!.isNewUser) {
          // save user to database

          userRepository
              .createUser(
                UserRequest(
                  uid: user!.uid,
                  email: user.email ?? "",
                  firstName: user.displayName ?? "",
                  lastName: "",
                  avatarBackgroundColor: "ffffff",
                  avatarURL: user.photoURL ?? "",
                ),
              )
              .then((value) => {saveUid(user!.uid)});
        } else {
          saveUid(user!.uid);
        }
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
      FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
        EasyLoading.showInfo("please_check_your".tr);
      });

      // saveUid(user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("L???i", "T??i kho???n ???? t???n t???i");
      }
    } catch (e) {
      Get.snackbar("L???i", "???? c?? l???i x???y ra");
    }

    return user;
  }

  Future<User?> signInWithEmailAndPassword(
      String yourEmail, String yourPassword) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: yourEmail, password: yourPassword);
      user = userCredential.user;
      if (user!.emailVerified) {
        saveUid(user.uid);
      } else {
        EasyLoading.showInfo("please_check_your".tr);
        user = null;
      }
      // saveUid(user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("L???i", "Email kh??ng t???n t???i");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("L???i", "Sai m???t kh???u");
      }
    }

    return user;
  }

  // Send user an email for password reset
  Future<void> resetPassword(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);

      EasyLoading.showInfo(
          "Vui l??ng ki???m tra email c???a b???n ????? ?????t l???i m???t kh???u",
          duration: Duration(seconds: 3));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.snackbar("L???i", "Email kh??ng t???n t???i");
      } else {
        Get.snackbar("L???i", "???? x???y ra l???i");
      }
    }
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
    await deleteUid("uid");
    await Get.offNamed(AppRoutes.WALK_THROUGH)!.then((value) {
      EasyLoading.showSuccess("logout_success".tr);
    });
  }
}
