import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moovy/core/constants/app_colors.dart';

class Wrapper extends StatelessWidget {
  final Widget child;
  const Wrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        child: child,
        value: SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: AppColors.blue,
            statusBarColor: AppColors.blue,
            statusBarIconBrightness: Brightness.dark));
  }
}
