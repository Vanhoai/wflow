part of 'firebase.dart';

class FirebaseAuthService {
  static Future<String> signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
    return await userCredential.user!.getIdToken() ?? '';
  }

  static Future<void> signInWithPhoneNumber() async {}
}
