import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constants_manager.dart';
import 'custom_tab_bar.dart';

class CategorySelector extends StatelessWidget {
  final CategoryModel selectedCategory;
  final Function(CategoryModel) onCategoryChanged;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            selectedCategory.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.h),
        CustomTabBar(
          categories: CategoryModel.getCategories(context),
          onCategoryItemClicked: onCategoryChanged,
        ),
      ],
    );
  }
}
