import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GoogleSignInModule {
  GoogleSignIn get googleSignIn => GoogleSignIn(scopes: ['email']);
}
