import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final List<String> favouriteEventsIds;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favouriteEventsIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      favouriteEventsIds:
          (json['favouriteEventsIds'] as List<dynamic>?)?.cast<String>() ?? [],
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    'favouriteEventsIds': favouriteEventsIds,
    "id": id,
    "name": name,
    "email": email,
  };

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? favouriteEventsIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      favouriteEventsIds: favouriteEventsIds ?? this.favouriteEventsIds,
    );
  }

  @override
  List<Object?> get props => [id, name, email, favouriteEventsIds];
}
