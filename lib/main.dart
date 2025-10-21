import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // <<< 1. IMPORT AJOUTÉ

import '../core/app_export.dart';
import '../widgets/custom_error_widget.dart';

// --- INITIALISATION DE SUPABASE ---
// L'URL de votre projet Supabase
const String supabaseUrl = 'https://jqzkseucnfibytrmtzv.supabase.co';
// Votre clé publique (anon key ) que vous avez fournie
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impxemtza2V1Y25maWJ5dHJtdHp2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwMDM4MzUsImV4cCI6MjA3NjU3OTgzNX0.DTdn2ShzCB8shchTaBS27yFEmYq-CNrs4D4I3b6tBms';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- 2. BLOC D'INITIALISATION DE SUPABASE AJOUTÉ ---
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  // --- FIN DU BLOC SUPABASE ---

  bool _hasShownError = false;

  // 🚨 CRITICAL: Custom error handling - DO NOT REMOVE
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (!_hasShownError) {
      _hasShownError = true;

      // Reset flag after 3 seconds to allow error widget on new screens
      Future.delayed(Duration(seconds: 5), () {
        _hasShownError = false;
      });

      return CustomErrorWidget(
        errorDetails: details,
      );
    }
    return SizedBox.shrink();
  };

  // 🚨 CRITICAL: Device orientation lock - DO NOT REMOVE
  // J'ai simplifié cette partie pour m'assurer que runApp est bien appelé après les initialisations.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(MyApp());
}

// --- 3. RACCOURCI GLOBAL POUR SUPABASE AJOUTÉ ---
final supabase = Supabase.instance.client;
// --- FIN DU RACCOURCI ---

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'neuratech',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        // 🚨 CRITICAL: NEVER REMOVE OR MODIFY
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        // 🚨 END CRITICAL SECTION
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initial,
      );
    });
  }
}
