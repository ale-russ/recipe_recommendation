import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_recommendation/util_methods.dart';

import 'firebase_options.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;
GoogleSignIn googleSignIn = GoogleSignIn();
GoogleSignInAccount? user;
late UserCredential userCredential;
final facebookAuth = FacebookAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  auth = FirebaseAuth.instanceFor(app: app);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log('user: ${user?.email}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      color: Colors.grey,
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  App({super.key});

  // final facebookLogin = FacebookAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginIcons(
              icon: const FaIcon(
                FontAwesomeIcons.squareGooglePlus,
                color: Colors.white,
                size: 50,
              ),
              onPressed: () async {
                googleLogin(context: context);
              },
            ),
            LoginIcons(
              onPressed: () {
                facebookLogin(context: context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
                size: 50,
              ),
            ),
            LoginIcons(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginIcons extends StatelessWidget {
  const LoginIcons({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final Widget icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
