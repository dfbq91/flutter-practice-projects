bool isNumber(String number) {
  if (number.isEmpty) return false;
  final convertedNumber = num.tryParse(number);
  return convertedNumber == null ? false : true;
}
