String? validatePhoneNumber({required String number}) {
  if (number.isEmpty) {
    return 'Phone Number is required';
  }
  if (!RegExp('03[0-9]{9}').hasMatch(number)) {
    return 'Number is not valid';
  }
  return null;
}

String? validateDoubleValue({required String value}) {
  if (value.isEmpty) {
    return 'Ammount is required';
  }
  var res = double.tryParse(value);
  if (res == null) {
    return 'Invalid Price';
  }
  return null;
}
