import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCategory {
  final String id;
  final String title;
  final String image;
  final IconData icon;

  AppCategory({
    required this.icon,
    required this.title,
    required this.image,
    required this.id,
  });

  static List<AppCategory> categories = [
    AppCategory(
      icon: Icons.book,
      title: "Book club",
      image: "assets/image/Book Club.png",
      id: "book club",
    ),
    AppCategory(
      icon: Icons.sports,
      title: "Sport",
      image: "assets/image/Sport.png",
      id: "sport",
    ),
    AppCategory(
      icon: Icons.cake_outlined,
      title: "Birthday",
      image: "assets/image/Birthday.png",
      id: "birthday",
    ),
    AppCategory(
      icon: Icons.account_balance_outlined,
      title: "Exhibition",
      image: "assets/image/Exhibition.png",
      id: "exhibition",
    ),
    AppCategory(
      icon: Icons.meeting_room,
      title: "Meeting",
      image: "assets/image/Meeting.png",
      id: "meeting",
    ),
  ];

  static AppCategory getCategoryById(String id) {
    return categories.firstWhere(
      (element) => element.id.toLowerCase() == id.toLowerCase(),
      orElse: () => categories.first,
    );
  }
}

