class PasswordService {
  static const _password = "1234";

  static bool checkPassword(String input) {
    return input == _password;
  }
}
