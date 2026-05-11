import 'package:evently_app/core/utils/colors_manager.dart';
import 'package:evently_app/core/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constants_manager.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.categories,
    this.onCategoryItemClicked,
  });
  final List<CategoryModel> categories;
  final void Function(CategoryModel)? onCategoryItemClicked;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            widget.onCategoryItemClicked?.call(
              widget.categories[selectedIndex],
            );
          });
        },
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelPadding: REdgeInsets.symmetric(horizontal: 8),
        tabs: widget.categories
            .map(
              (category) => TabItem(
                category: category,
                selectedBgColor: ColorsManager.darkBlue,
                selectedFgColor: Colors.white,
                unSelectedBgColor: ColorsManager.white,
                unSelectedFgColor: ColorsManager.black,
                isSelected:
                    widget.categories.indexOf(category) == selectedIndex,
              ),
            )
            .toList(),
      ),
    );
  }
}

