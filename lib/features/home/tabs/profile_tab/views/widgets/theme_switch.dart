import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/colors_manager.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../view_model/profile_bloc.dart';
import '../../view_model/profile_event.dart';
import '../../view_model/profile_state.dart';


class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.w,
            ),
            color: Theme.of(context).primaryColor,
          ),
          width: double.infinity,
          child: Row(
            children: [
              Text(
                appLocalizations.dark_mode,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Spacer(),
              Switch(
                activeThumbColor: ColorsManager.darkBlue,
                activeTrackColor: ColorsManager.white,
                inactiveThumbColor: ColorsManager.grey,
                inactiveTrackColor: ColorsManager.white,
                value: state.themeMode == ThemeMode.dark,
                onChanged: (isDarkEnabled) {
                  context.read<ProfileBloc>().add(
                    ChangeThemeEvent(
                      isDarkEnabled ? ThemeMode.dark : ThemeMode.light,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
