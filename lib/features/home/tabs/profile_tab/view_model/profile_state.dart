import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileState extends Equatable {
  final ThemeMode themeMode;
  final String language;

  const ProfileState({
    required this.themeMode,
    required this.language,
  });

  ProfileState copyWith({
    ThemeMode? themeMode,
    String? language,
  }) {
    return ProfileState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [themeMode, language];
}
