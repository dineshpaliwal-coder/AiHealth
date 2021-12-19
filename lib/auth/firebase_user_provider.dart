import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AiHealthFirebaseUser {
  AiHealthFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AiHealthFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AiHealthFirebaseUser> aiHealthFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AiHealthFirebaseUser>(
            (user) => currentUser = AiHealthFirebaseUser(user));
