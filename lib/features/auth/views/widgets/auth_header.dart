import 'package:flutter/material.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(ImageAssets.evenltyLogo, color: ColorsManager.blue),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
