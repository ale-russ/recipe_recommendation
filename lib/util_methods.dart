import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';
import 'main.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

DocumentSnapshot? userProfile;

Future<DocumentSnapshot> getUserProfile(String uid) async {
  userProfile = await firestore.collection('user').doc(uid).get();
  return await firestore.collection('user').doc(uid).get();
}

void googleLogin({BuildContext? context}) async {
  var navigator = Navigator.of(context!);

  try {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    // log('googleSiginInAccount: $googleSignInAccount');
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    UserCredential userCredential = await auth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken));

    if (userCredential.user != null) {
      getUserProfile(googleSignInAccount.id);
      user = googleSignIn.currentUser;
      log('USER: ${user?.displayName}');

      navigator.push(MaterialPageRoute(builder: (context) => HomePage()));
    }
  } on Exception catch (err) {
    log('Error: $err');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error loging in: $err'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

void facebookLogin({BuildContext? context}) async {
  var navigator = Navigator.of(context!);
  facebookAuth.login().then((value) {
    if (value.status == LoginStatus.success) {
      log('Value: $value');
      navigator.push(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (value.status == LoginStatus.cancelled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Operation Cancelled by user'),
        ),
      );
      navigator.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Opps... Unable to login. Please try again'),
        ),
      );
      navigator.pop();
    }
  });
}
