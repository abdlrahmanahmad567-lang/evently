import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FairbaseServies {
  Future<UserCredential?> createAccount({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateProfile(displayName: name);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is not valid.';
      } else {
        throw e.message ?? "Failed to create account";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> login({
    required String password,
    required String email,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided.';
      } else if (e.code == 'invalid-credential') {
        throw 'Invalid email or password.';
      } else if (e.code == 'user-disabled') {
        throw 'This user account has been disabled.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is invalid.';
      } else {
        throw e.message ?? 'Wrong email or password.';
      }
    } catch (e) {
      rethrow;
    }
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId:
            "77376679273-c4ca4k4qfkn0ljfi7ogbm5vkm7h4dlhv.apps.googleusercontent.com",
      );
      final GoogleSignInAccount result = await _googleSignIn.authenticate();
      final googleAuth = result.authentication;
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Authentication failed";
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential?> singInWhithGoogle() async {
    return FairbaseServies().signInWithGoogle();
  }

  Future<void> resetPassword(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
