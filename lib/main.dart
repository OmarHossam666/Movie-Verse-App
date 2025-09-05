import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/cinematica.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();

  runApp(const Cinematica());
}
