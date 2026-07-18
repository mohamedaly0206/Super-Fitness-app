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

    final GoogleSignInAccount account = await GoogleSignIn.instance
        .authenticate();

    final idToken = account.authentication.idToken;

    final authorization =
        await account.authorizationClient.authorizationForScopes([
          'email',
        ]) ??
        await account.authorizationClient.authorizeScopes(['email']);

    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: authorization.accessToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final displayName = userCredential.user?.displayName ?? account.displayName;
    final email = userCredential.user?.email ?? account.email;

    String? firstName;
    String? lastName;
    if (displayName != null && displayName.trim().isNotEmpty) {
      final parts = displayName.trim().split(RegExp(r'\s+'));
      firstName = parts.first;
      lastName = parts.length > 1 ? parts.sublist(1).join(' ') : null;
    }

    return GoogleAuthResult(firstName: firstName, lastName: lastName, email: email);
  }
}
