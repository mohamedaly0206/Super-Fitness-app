import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

/// Minimal result of a successful Google authentication, deliberately
/// decoupled from [UserEntity]/Firebase types so callers (e.g. cubits)
/// don't need to depend on Firebase directly.
class GoogleAuthResult {
  final String? firstName;
  final String? lastName;
  final String? email;

  const GoogleAuthResult({this.firstName, this.lastName, this.email});
}

abstract class GoogleAuthService {
  /// Runs the full Google + Firebase sign-in flow and returns the
  /// available profile info, or null if the user cancelled.
  Future<GoogleAuthResult?> signIn();
}

@LazySingleton(as: GoogleAuthService)
class GoogleAuthServiceImpl implements GoogleAuthService {
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  @override
  Future<GoogleAuthResult?> signIn() async {
    await _ensureInitialized();

    GoogleSignInAccount account;
    try {
      account = await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        return null;
      }
      rethrow;
    }

    final idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw Exception('Google sign-in failed: missing ID token.');
    }

    String? accessToken;
    try {
      final authorization = await account.authorizationClient
          .authorizationForScopes(['email']);
      accessToken = authorization?.accessToken;
    } catch (_) {
      accessToken = null;
    }

    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );

    String? email = account.email;
    String? displayName = account.displayName;
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      displayName = userCredential.user?.displayName ?? account.displayName;
      email = userCredential.user?.email ?? account.email;
    } catch (_) {
      // Fall back to the Google account profile when Firebase is unavailable,
      // so the social login can still continue with the user's email.
    }

    String? firstName;
    String? lastName;
    if (displayName != null && displayName.trim().isNotEmpty) {
      final parts = displayName.trim().split(RegExp(r'\s+'));
      firstName = parts.first;
      lastName = parts.length > 1 ? parts.sublist(1).join(' ') : null;
    }

    return GoogleAuthResult(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }
}
