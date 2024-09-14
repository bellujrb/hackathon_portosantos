import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/svg_enum.dart';

class SvgCustom extends StatelessWidget {
  final SvgEnum svg;
  final double? height;
  final double? width;
  const SvgCustom(
      {super.key, required this.svg, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg.path,
      height: height,
      width: width,
    );
  }
}
