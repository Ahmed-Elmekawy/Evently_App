import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_button.dart';

class DateTimeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String buttonTitle;
  final VoidCallback onTap;

  const DateTimeRow({
    super.key,
    required this.icon,
    required this.label,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.iconTheme.color),
        SizedBox(width: 8.w),
        Text(
          label,
          style: theme.textTheme.displayLarge,
        ),
        const Spacer(),
        CustomTextButton(
          title: buttonTitle,
          onTap: onTap,
        ),
      ],
    );
  }
}
