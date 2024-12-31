import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color primary = const Color.fromARGB(255, 175, 142, 129);
List<String> routes = [
  'Model Town',
  'Setlite Town',
  'Nawakot Road',
  'Gareeb Abad',
  'Eye Hospital Road'
];

TextInputFormatter phonerNumberFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'(+92[0-9]{10}|03[0-9]{9})'));
TextInputFormatter amountFormatter = FilteringTextInputFormatter.digitsOnly;
