import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color primary = const Color.fromARGB(255, 175, 142, 129);

PageSize legalPage = PageSize(816, 1344);
PageSize a4Page = PageSize(796, 1123);

List<String> routes = [
  'Model Town',
  'Setlite Town',
  'Nawakot Road',
  'Gareeb Abad',
  'Eye Hospital Road'
];

class PageSize {
  double width;
  double height;

  PageSize(this.width, this.height);
}
