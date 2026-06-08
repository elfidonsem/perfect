import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:perfect/models/app_user.dart';
// import 'package:lelohub/models/app_user.dart';

class AuthService {
  // initialisation l'authentification
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // initialisation et création d'une collection utilisateurs
  final data = FirebaseFirestore.instance.collection("users");

  // Fonction pour inscrire et  créer utilisateur
  Future<void> createUser(String name, String email, String password) async {
    try {
      // inscription de l'utilisateur
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // user couranment connecter sur firebase
      final currentUser = cred.user!.uid;
      // creation d'un utilisateur avec notre model
      final appUser = AppUser(
        name: name,
        uid: currentUser,
        email: email,
        age: "",
      );
      // base donnée
      data.doc(currentUser).set(appUser.toJson());
    } catch (e) {
      ScaffoldMessenger(
        child: SnackBar(content: Text("Une erreur de type : $e")),
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      ScaffoldMessenger(
        child: SnackBar(content: Text("Une erreur de type : $e")),
      );
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  // cd android
  // gradlew signingReport

  Future<void> signInWithGoogle() async {
    try {
      // ================= WEB =================
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        final userCredential = await auth.signInWithPopup(googleProvider);

        final user = userCredential.user;

        if (user != null) {
          final docSnapshot = await data.doc(user.uid).get();

          if (!docSnapshot.exists) {
            final appUser = AppUser(
              name: user.displayName ?? "User",
              uid: user.uid,
              email: user.email ?? "",
              age: "",
            );

            await data.doc(user.uid).set(appUser.toJson());
          }
        }

        return;
      }

      // ================= MOBILE =================

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("object");

      // utilisateur annule
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
        final docSnapshot = await data.doc(user.uid).get();

        if (!docSnapshot.exists) {
          final appUser = AppUser(
            name: user.displayName ?? "User",
            uid: user.uid,
            email: user.email ?? "",
            age: "",
          );

          await data.doc(user.uid).set(appUser.toJson());
        }
      }
    } catch (e) {
      ScaffoldMessenger(
        child: SnackBar(content: Text("Une erreur de type : $e")),
      );
      rethrow;
    }
  }
}
