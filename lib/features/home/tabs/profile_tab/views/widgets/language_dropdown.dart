import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/core/utils/colors_manager.dart';
import '../../view_model/profile_bloc.dart';
import '../../view_model/profile_event.dart';
import '../../view_model/profile_state.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Text(
                state.language == "en" ? "English" : "Arabic",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Spacer(),
              DropdownButton<String>(
                dropdownColor: ColorsManager.white,
                padding: EdgeInsets.zero,
                underline: Container(),
                items: ["English", "Arabic"]
                    .map(
                      (lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(
                          lang,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (newLang) {
                  if (newLang != null) {
                    context.read<ProfileBloc>().add(
                      ChangeLanguageEvent(newLang == "English" ? "en" : "ar"),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
