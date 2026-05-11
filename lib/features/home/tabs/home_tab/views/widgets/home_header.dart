import 'package:flutter/material.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../auth/data/models/user_model.dart';

class HomeHeader extends StatelessWidget {
  final UserModel? user;

  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${appLocalizations.welcome_back} ✨",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                user?.name ?? "User",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
