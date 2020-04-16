class AppStrings {
  AppStrings._();

  static const String appName = "Flutter Boilerplate";

  //splash screen
  static const String splashTitle = "Welcome to ";

  //home screen
  static const String homeAppBarTitle = "Todos";

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
  static const String todosCreateEditTaskNameValidatorMsg =
      "Name can't be empty";
  static const String todosCreateEditCompletedTxt = "Completed ?";

  //empty screen - used in todos screen
  static const String todosEmptyTopMsgDefaultTxt = "Nothing here";
  static const String todosEmptyBottomDefaultMsgTxt =
      "Add a new item to get started";
}
