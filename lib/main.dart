import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect/core/router/app_router.dart';
import 'package:perfect/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:perfect/features/auth/data/services/firebase_auth_service.dart';
import 'package:perfect/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:perfect/features/auth/presentation/bloc/auth_event.dart';
import 'package:perfect/firebase_options.dart';

// ==============================
// Fonction principale de l'application
// ==============================

Future<void> main() async {
  // Permet d'initialiser Flutter avant Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Firebase
  await Firebase.initializeApp(
    // Configuration automatique selon Android / iOS / Web
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Lancement de l'application
  runApp(const MyApp());
}

// ==============================
// Widget principal
// ==============================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepositoryImpl = AuthRepositoryImpl(FirebaseAuthService());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepositoryImpl)..add(AuthInitialEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // Nom application
        title: 'Perfect',

        // Theme global application
        theme: ThemeData(
          // Génère automatiquement les couleurs
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),

        routerConfig: appRouter,
      ),
    );
  }
}
