
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String userId;
  String title;
  String description;
  String categoryId;
  String categoryTitle;
  String image;
  DateTime eventDate;
  String eventTime;
  bool isFavorite;

  EventModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.categoryTitle,
    required this.image,
    required this.eventDate,
    required this.eventTime,
    this.isFavorite = false,
  });

  factory EventModel.fromJson(Map<String, dynamic> json, {String? id}) {
    DateTime parsedDate;
    var rawDate = json['eventDate'];
    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate is int) {
      parsedDate = DateTime.fromMillisecondsSinceEpoch(rawDate);
    } else if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return EventModel(
      id: id ?? json['id'],
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryTitle: json['categoryTitle'] ?? '',
      image: json['image'] ?? '',
      eventDate: parsedDate,
      eventTime: json['eventTime'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'image': image,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'eventTime': eventTime,
      'isFavorite': isFavorite,
    };
  }
}
