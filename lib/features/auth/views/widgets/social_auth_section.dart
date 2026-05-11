import 'package:evently_app/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/assets_manager.dart';

class GoogleAuthSection extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GoogleAuthSection({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: ColorsManager.grey, thickness: 1),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Or",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: ColorsManager.darkBlue,
                  fontSize: 16.sp,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: ColorsManager.grey, thickness: 1),
            ),
          ],
        ),
        24.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onPressed,
            icon: Image.asset(ImageAssets.google, height: 24.w, width: 24.w),
            label: Text(label),
          ),
        ),
      ],
    );
  }
}

