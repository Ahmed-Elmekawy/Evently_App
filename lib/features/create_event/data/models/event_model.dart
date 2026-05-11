import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/constants_manager.dart';

class EventModel {
  String? ownerId;
  String? id;
  String? title;
  String? description;
  String? categoryId;
  DateTime? dateTime;

  CategoryModel? category;

  EventModel({
    required this.ownerId,
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.dateTime,
    this.category,
  });

  EventModel.fromJson(Map<String, dynamic>? json)
    : this(
        ownerId: json?['ownerId'],
        id: json?['id'],
        title: json?['title'],
        description: json?['description'],
        dateTime: (json?['dateTime'] as Timestamp).toDate(),
        categoryId: json?['categoryId'],
      );

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'categoryId': categoryId,
    };
  }
}
