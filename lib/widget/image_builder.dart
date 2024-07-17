import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture buildSvgPicture({required String image, required double size, Color? color, BoxFit fit = BoxFit.contain}) => SvgPicture.asset(image, height: size, width: size, fit: fit,);
Image buildImagePicture({required String image, required double size, Color? color, BoxFit? fit}) => Image.asset(image, height: size, width: size, fit: fit,);