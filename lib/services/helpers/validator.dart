class Validator {
  static String email(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String password(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String name(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a name.';
    else
      return null;
  }

  static String number(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a number.';
    else
      return null;
  }

  static String amount(String value) {
    Pattern pattern = r'^\d+$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a number i.e. 250 (no \$ and no cents)';
    else
      return null;
  }

  static String notEmpty(String value) {
    Pattern pattern = r'^\S+$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'This is a required field.';
    else
      return null;
  }
}
