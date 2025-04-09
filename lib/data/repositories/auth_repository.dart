import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;
  
  // Get current user
  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
      );
    }
    return null;
  }

  // Email & Password Sign In
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user != null) {
        return UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName ?? '',
          photoUrl: userCredential.user!.photoURL,
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Google Sign In
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Get auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        return UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName ?? '',
          photoUrl: userCredential.user!.photoURL,
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Up with Email & Password
  Future<UserModel?> signUpWithEmail(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile with name
      await userCredential.user?.updateDisplayName(name);
      
      if (userCredential.user != null) {
        return UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: name,
          photoUrl: userCredential.user!.photoURL,
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      rethrow;
    }
  }

  // Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Optional: Verify Password Reset Code
  Future<bool> verifyPasswordResetCode(String code) async {
    try {
      await _auth.verifyPasswordResetCode(code);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Optional: Confirm Password Reset
  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
    } catch (e) {
      rethrow;
    }
  }
} 