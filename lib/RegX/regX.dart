bool isvalidemail(String email) {
  return RegExp(
    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
  ).hasMatch(email);
}

bool isValidPassword(String password) {
  final regex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~.,%/\-_=+]).{8,}$');
  return regex.hasMatch(password);
}
