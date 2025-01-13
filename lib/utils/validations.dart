import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

var cnicformatter = MaskTextInputFormatter(
    mask: '#####-#######-#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var customerCode = MaskTextInputFormatter(
    mask: '####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

TextInputFormatter phonerNumberFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'(+92[0-9]{10}|03[0-9]{9})'));
TextInputFormatter amountFormatter = FilteringTextInputFormatter.digitsOnly;
