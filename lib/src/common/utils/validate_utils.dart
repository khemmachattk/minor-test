bool isMobile(String value) {
  RegExp regExp = RegExp(r'^0\d{9}$');
  return regExp.hasMatch(value);
}