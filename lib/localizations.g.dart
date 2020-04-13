// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizations.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

class AppLocalizations {
  AppLocalizations(this.locale) : this.labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalizations_Labels> languages = {
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      auth: AppLocalizations_Labels_Auth(
        signInButton: "Sign In",
        signUpButton: "Sign Up",
        forgotPasswordButton: "Forgot Password",
        emailFormField: "Email",
        passwordFormField: "Password",
        nameFormField: "Name",
        signInError: "Login failed: email or password incorrect.",
        forgotPasswordLabelButton: "Forgot password?",
        signUpLabelButton: "Create an Account",
        signUpError: "Sign up failed.",
        signInLabelButton: "Have an Account? Sign In.",
        forgotPasswordNotice:
            "Check your email and follow the instructions to reset your password.",
        signInonForgotPasswordLabelButton: "Sign In",
      ),
    ),
    Locale.fromSubtags(languageCode: "fr"): AppLocalizations_Labels(
      auth: AppLocalizations_Labels_Auth(
        signInButton: "Se connecter",
        signUpButton: "S'inscrire",
        forgotPasswordButton: "Mot de passe oublié",
        emailFormField: "Email",
        passwordFormField: "Mot de passe",
        nameFormField: "Nom",
        signInError: "Échec de la connexion: e-mail ou mot de passe incorrect.",
        forgotPasswordLabelButton: "Mot de passe oublié?",
        signUpLabelButton: "Créer un compte",
        signUpError: "Inscrivez-vous échoué.",
        signInLabelButton: "Avoir un compte? Se connecter.",
        forgotPasswordNotice:
            "Vérifiez votre e-mail et suivez les instructions pour réinitialiser votre mot de passe.",
        signInonForgotPasswordLabelButton: "Se connecter",
      ),
    ),
    Locale.fromSubtags(languageCode: "es"): AppLocalizations_Labels(
      auth: AppLocalizations_Labels_Auth(
        signInButton: "Registrarse",
        signUpButton: "Regístrate",
        forgotPasswordButton: "Se te olvidó tu contraseña",
        emailFormField: "Email",
        passwordFormField: "Contraseña",
        nameFormField: "Nombre",
        signInError:
            "La conexión falló: correo electrónico o contraseña incorrecta.",
        forgotPasswordLabelButton: "¿Se te olvidó tu contraseña?",
        signUpLabelButton: "Crea una cuenta",
        signUpError: "Registro fallido.",
        signInLabelButton: "¿Tener una cuenta? Registrarse.",
        forgotPasswordNotice:
            "Consultar su correo electrónico y siga las instrucciones para restablecer su contraseña.",
        signInonForgotPasswordLabelButton: "Registrarse",
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

class AppLocalizations_Labels_Auth {
  const AppLocalizations_Labels_Auth(
      {this.signInButton,
      this.signUpButton,
      this.forgotPasswordButton,
      this.emailFormField,
      this.passwordFormField,
      this.nameFormField,
      this.signInError,
      this.forgotPasswordLabelButton,
      this.signUpLabelButton,
      this.signUpError,
      this.signInLabelButton,
      this.forgotPasswordNotice,
      this.signInonForgotPasswordLabelButton});

  final String signInButton;

  final String signUpButton;

  final String forgotPasswordButton;

  final String emailFormField;

  final String passwordFormField;

  final String nameFormField;

  final String signInError;

  final String forgotPasswordLabelButton;

  final String signUpLabelButton;

  final String signUpError;

  final String signInLabelButton;

  final String forgotPasswordNotice;

  final String signInonForgotPasswordLabelButton;
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels({this.auth});

  final AppLocalizations_Labels_Auth auth;
}
