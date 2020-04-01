class AppStrings {
  AppStrings._();

  static const String appName = "Flutter Boilerplate";

  //splash screen
  static const String splashTitle = "Welcome to ";

  //alert dialog
  static const String alertDialogTitle = "Alert";
  static const String alertDialogMessage = "This will logout. Are you sure?";
  static const String alertDialogCancelBtn = "Cancel";
  static const String alertDialogYesBtn = "Yes";

  //sign-in and new user registration screens
  static const String loginTxtEmail = "Email";
  static const String loginTxtPassword = "Password";
  static const String loginBtnSignIn = "Sign In";
  static const String loginBtnSignUp = "Sign Up";
  static const String loginTxtDontHaveAccount = "Don't have an account?";
  static const String loginTxtHaveAccount = "Already have an account?";
  static const String loginBtnLinkCreateAccount = "Create account";
  static const String loginBtnLinkSignIn = "Sign in";
  static const String loginTxtErrorEmail = "Please enter an email";
  static const String loginTxtErrorPassword =
      "Please enter a password with 6+ chars long";

  static const String loginTxtErrorSignIn = "Invalid email and/or password";

  //home screen
  static const String homeAppBarTitle = "Todos";

  //setting screen
  static const String settingAppTitle = "Setting";
  static const String settingThemeListTitle = "Dark theme";
  static const String settingThemeListSubTitle = "Turn On the Dark Side";
  static const String settingLogoutListTitle = "Logout";
  static const String settingLogoutListSubTitle = "Log me out from here";
  static const String settingLogoutButton = "Logout";

  //todos screen
  static const String todosSnackBarContent = "Deleted ";
  static const String todosSnackBarActionLbl = "Undo";
  static const String todosErrorTopMsgTxt = "Something went wrong";
  static const String todosErrorBottomMsgTxt = "Can't load data right now";
  static const String todosDismissibleMsgTxt = "Delete";
  static const String todosPopUpToggleAllComplete = "Mark all complete";
  static const String todosPopUpToggleClearCompleted = "Clear all completed";
  static const String todosCreateEditAppBarTitleNewTxt = "New Todo";
  static const String todosCreateEditAppBarTitleEditTxt = "Edit Todo";
  static const String todosCreateEditTaskNameTxt = "Todo Name";
  static const String todosCreateEditNotesTxt = "Notes";
  static const String todosCreateEditTaskNameValidatorMsg = "Name can't be empty";
  static const String todosCreateEditCompletedTxt = "Completed ?";

  //empty screen - used in todos screen
  static const String todosEmptyTopMsgDefaultTxt = "Nothing here";
  static const String todosEmptyBottomDefaultMsgTxt =
      "Add a new item to get started";
}
