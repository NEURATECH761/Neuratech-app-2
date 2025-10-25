import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/app_export.dart';
import '../widgets/custom_error_widget.dart';

// --- LECTURE DES VARIABLES D'ENVIRONNEMENT ---
// Ces lignes lisent les clés que vous allez configurer sur Vercel.
// Pour le mobile, elles liront les clés depuis un fichier de configuration.
const String supabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'https://jqzkseucnfibytrmtzv.supabase.co', // <-- Valeur pour le mobile
  );
const String supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_ANON_KEY',
  defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impxemtza2V1Y25maWJ5dHJtdHp2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwMDM4MzUsImV4cCI6MjA3NjU3OTgzNX0.DTdn2ShzCB8shchTaBS27yFEmYq-CNrs4D4I3b6tBms', // <-- Valeur pour le mobile
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- INITIALISATION DE SUPABASE (CORRIGÉE) ---
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    // 👇 LA CORRECTION EST ICI.
    // Ceci force l'utilisation de la redirection sécurisée pour le web.
    authFlowType: AuthFlowType.pkce,
  );
  // --- FIN DU BLOC SUPABASE ---

  bool _hasShownError = false;

  // 🚨 CRITICAL: Custom error handling - DO NOT REMOVE
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (!_hasShownError) {
      _hasShownError = true;
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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(MyApp());
}

// --- RACCOURCI GLOBAL POUR SUPABASE ---
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
