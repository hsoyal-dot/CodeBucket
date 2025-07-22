import 'package:flutter/material.dart';

Widget getPlatformIcon(String url) {
  final domain = Uri.tryParse(url)?.host ?? '';

  if (domain.contains('leetcode')) {
    return Image.asset('assets/images/leetcode.png', height: 24, width: 24);
  } else if (domain.contains('geeksforgeeks') || domain.contains('gfg')) {
    return Image.asset('assets/images/gfg.png', height: 24, width: 24);
  } else if (domain.contains('hackerrank')) {
    return Image.asset('assets/images/hackerrank.png', height: 24, width: 24);
  } else if (domain.contains('hackerearth')) {
    return Image.asset('assets/images/hackerearth.png', height: 24, width: 24);
  }
  return Image.asset('assets/images/default.png', height: 24, width: 24);
}
