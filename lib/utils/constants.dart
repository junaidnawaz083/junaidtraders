import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color primary = const Color.fromARGB(255, 175, 142, 129);

PageSize legalPage = PageSize(816, 1344);
PageSize a4Page = PageSize(796, 1123);

List<String> routes_city1 = [
  'Model Town A/B',
  'Setlite Town',
  'Gareeb Abad',
  'Bagho Bahar',
  'Eye Hospital',
  'Nawakot Road',
];
List<String> routes_Sole = [
  'Zahir Peer',
  'Sajah',
  'Feroza',
  'Nawakot',
  'Gari Ikhtiar Khan',
  'Baghobahar',
];
//'Airport Road',

class PageSize {
  double width;
  double height;

  PageSize(this.width, this.height);
}
