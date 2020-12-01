import 'package:firebase_auth/firebase_auth.dart';

class NetworkService {
  final FirebaseAuth auth;
  NetworkService(this.auth);

  //Login
  Future<String> login(String email, String pass) async {
    String message = 'login error';
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (userCredential.user.emailVerified) {
        message = '';
        print('Login successfull');
      } else {
        await FirebaseAuth.instance.signOut();
        message = 'Email not verified!';
        print(message);
      }
    } catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        print(message);
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        print(message);
      }
    }
    return message;
  }

  //Sign UP
  Future signUp(username, pass, email) async {
    String message = 'Signup error';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      try {
        userCredential.user.updateProfile(displayName: username);
        await userCredential.user.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
        message = 'Registration successfull';
        print(message);
      } catch (e) {
        message =
            'An error occured while trying to send email verification. Please try again later.';
        print(message);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print(message);
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        print(message);
      }
    } catch (e) {
      message = 'Error in registration! Please try again later.';
      print(e.toString());
    }
    return message;
  }

  //Logout
  Future<String> logout() async {
    String message = 'logout error';
    try {
      await FirebaseAuth.instance.signOut();
      message = '';
      print('logout successfull');
    } catch (e) {
      print(e);
    }
    return message;
  }

  Future<String> sendEmailValidation(String email, String password) async {
    String message = 'Error in sending email validation';
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user.sendEmailVerification();
      message = 'Email validation sent';
      await FirebaseAuth.instance.signOut();
      print(message);
    } catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        print(message);
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        print(message);
      }
    }
    return message;
  }

  Future<String> sendResetPassword(String email) async {
    String message = 'Error in sending the password';
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      message = 'Email with new password sent';
      print(message);
    } catch (e) {
      if (e.code.toString().contains('user-not-found')) {
        message = 'No user found for that email.';
        print(message);
      } else
        print('E.CODE: ' + e.code.toString());
    }
    return message;
  }
}
