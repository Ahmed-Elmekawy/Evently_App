import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/core/utils/prefs_manager.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileState(
          themeMode: PrefsManager.getSavedTheme() ?? ThemeMode.light,
          language: PrefsManager.getLanguage() ?? "en",
        )) {
    on<ChangeThemeEvent>((event, emit) {
      PrefsManager.saveTheme(event.themeMode);
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<ChangeLanguageEvent>((event, emit) {
      PrefsManager.saveLanguage(event.language);
      emit(state.copyWith(language: event.language));
    });
  }
}

