import 'package:evently_app/core/utils/assets_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/tabs/profile_tab/view_model/profile_bloc.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
  });

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};

  static List<CategoryModel> getCategories(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isDark = context.read<ProfileBloc>().state.themeMode == ThemeMode.dark;

    List<CategoryModel> categories = [
      CategoryModel(
        id: "1",
        name: appLocalizations.sports,
        icon: Icons.sports_football,
        image: isDark ? ImageAssets.sportDark : ImageAssets.sportLight,
      ),
      CategoryModel(
        id: "2",
        name: appLocalizations.birthday,
        icon: Icons.cake_outlined,
        image: isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight,
      ),
      CategoryModel(
        id: "3",
        name: appLocalizations.book_club,
        icon: Icons.bookmark_border_outlined,
        image: isDark ? ImageAssets.bookClubDark : ImageAssets.bookClubLight,
      ),
      CategoryModel(
        id: "4",
        name: appLocalizations.exhibition,
        icon: Icons.water_drop_rounded,
        image: isDark
            ? ImageAssets.exhibitionDark
            : ImageAssets.exhibitionLight,
      ),
    ];
    return categories;
  }

  static List<CategoryModel> getCategoriesWithAll(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isDark = context.read<ProfileBloc>().state.themeMode == ThemeMode.dark;

    List<CategoryModel> categories = [
      CategoryModel(
        id: "0",
        name: appLocalizations.all,
        icon: Icons.all_inclusive,
        image: isDark ? ImageAssets.meetingDark : ImageAssets.meetingLight,
      ),
      CategoryModel(
        id: "1",
        name: appLocalizations.sports,
        icon: Icons.sports_football,
        image: isDark ? ImageAssets.sportDark : ImageAssets.sportLight,
      ),
      CategoryModel(
        id: "2",
        name: appLocalizations.birthday,
        icon: Icons.cake_outlined,
        image: isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight,
      ),
      CategoryModel(
        id: "3",
        name: appLocalizations.book_club,
        icon: Icons.bookmark_border_outlined,
        image: isDark ? ImageAssets.bookClubDark : ImageAssets.bookClubLight,
      ),
      CategoryModel(
        id: "4",
        name: appLocalizations.exhibition,
        icon: Icons.water_drop_rounded,
        image: isDark
            ? ImageAssets.exhibitionDark
            : ImageAssets.exhibitionLight,
      ),
    ];
    return categories;
  }
}

abstract class RemoteConstant {
  static const String userCollection = "Users";
  static const String eventsCollection = "Events";
}

