// login_ecran.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'liste_produits.dart'; // Assuming ListeProduits resides here

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // if snapshot has data, return home page
        // if not logged in, show the sign-in screen
        return ListeProduits();
      },
    );
  }
}