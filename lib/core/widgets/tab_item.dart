import 'package:evently_app/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants_manager.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.category,
    required this.selectedBgColor,
    required this.selectedFgColor,
    required this.unSelectedBgColor,
    required this.unSelectedFgColor,
    required this.isSelected,
  });

  final CategoryModel category;
  final Color selectedBgColor;
  final Color selectedFgColor;
  final Color unSelectedBgColor;
  final Color unSelectedFgColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? selectedBgColor : unSelectedBgColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.grey, width: 1.w),
      ),

      child: Row(
        children: [
          Icon(
            category.icon,
            color: isSelected ? selectedFgColor : unSelectedFgColor,
          ),
          SizedBox(width: 8.w),
          Text(
            category.name,
            style: TextStyle(
              color: isSelected ? selectedFgColor : unSelectedFgColor,
            ),
          ),
        ],
      ),
    );
  }
}
