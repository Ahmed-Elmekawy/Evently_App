
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ChangeThemeEvent extends ProfileEvent {
  final ThemeMode themeMode;

  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ChangeLanguageEvent extends ProfileEvent {
  final String language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object?> get props => [language];
}
