import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.align = TextAlign.center,
    this.onTap,
  });
  final String title;
  final TextAlign align;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,

        textAlign: align,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
