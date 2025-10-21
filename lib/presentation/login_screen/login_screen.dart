import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // <<< IMPORT SUPABASE

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/login_form_widget.dart';
import './widgets/neuratech_logo_widget.dart';
import './widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  // La variable supabase pour un accès facile
  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // --- FONCTION DE CONNEXION GOOGLE MISE À JOUR ---
  Future<void> _handleGoogleLogin() async {
    // Affiche l'indicateur de chargement
    setState(() {
      _isLoading = true;
    });

    try {
      // Lance le processus d'authentification OAuth avec Google
      // Supabase s'occupe de tout (ouvrir la page, gérer la redirection)
      await supabase.auth.signInWithOAuth(OAuthProvider.google);

      // Note : Après la connexion, Supabase redirige vers l'application.
      // La gestion de l'état (passer à l'écran d'accueil) se fera
      // en écoutant "onAuthStateChange" dans votre main.dart ou un widget parent.
      // Pour l'instant, nous ne masquons le chargement que si l'utilisateur annule.

    } catch (e) {
      // Si l'utilisateur annule ou si une erreur se produit
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'La connexion a été annulée ou a échoué.',
              style: AppTheme.darkTheme.textTheme.bodyMedium,
            ),
            backgroundColor: AppTheme.errorSoft,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // Masque l'indicateur de chargement si le widget est toujours affiché
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // J'ai laissé les autres fonctions pour ne pas casser votre code,
  // mais la logique de connexion email/mot de passe devra aussi être remplacée
  // par les fonctions de Supabase (supabase.auth.signInWithPassword).
  Future<void> _handleLogin(String email, String password) async {
    // TODO: Remplacer cette logique par supabase.auth.signInWithPassword
  }

  Future<void> _handleAppleLogin() async {
    // TODO: Implémenter la connexion Apple avec Supabase
  }

  void _navigateToSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "La fonctionnalité d'inscription sera bientôt disponible.",
          style: AppTheme.darkTheme.textTheme.bodyMedium,
        ),
        backgroundColor: AppTheme.surfaceDialog,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.h),

                    // Logo Neuratech
                    const NeuratechLogoWidget(),

                    SizedBox(height: 6.h),

                    // Texte de bienvenue
                    Text(
                      'Ravi de vous revoir', // <<< TRADUIT
                      style:
                          AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'Connectez-vous pour continuer votre apprentissage', // <<< TRADUIT
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 4.h),

                    // Formulaire de connexion
                    LoginFormWidget(
                      onLogin: _handleLogin,
                      isLoading: _isLoading,
                    ),

                    SizedBox(height: 4.h),

                    // Options de connexion sociale
                    SocialLoginWidget(
                      isLoading: _isLoading,
                      onGoogleLogin: _handleGoogleLogin, // <<< FONCTION MISE À JOUR
                      onAppleLogin: _handleAppleLogin,
                    ),

                    SizedBox(height: 4.h),

                    // Lien d'inscription
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nouveau ? ', // <<< TRADUIT
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed: _isLoading ? null : _navigateToSignUp,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "S'inscrire", // <<< TRADUIT
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.accentCoral,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
