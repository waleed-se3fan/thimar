validate({required String value, required String text}) {
  if (value.isEmpty) {
    return text;
  }
  return null;
}
