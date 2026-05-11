import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text_button.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String buttonTitle;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.text,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        CustomTextButton(
          title: buttonTitle,
          onTap: onTap,
        ),
      ],
    );
  }
}
