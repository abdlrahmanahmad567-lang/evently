import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../cor/constant/app_Category.dart';
import '../../../cor/services/toast.dart';
import '../models/event_model.dart';
import '../services/event_firebase_service.dart';

class EventProvider extends ChangeNotifier {
  int tabIndex = 0;
  DateTime? eventDate;
  TimeOfDay? eventTime;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;

  void changeDate(DateTime? date) {
    eventDate = date;
    notifyListeners();
  }

  void ChangeTime(TimeOfDay? time) {
    eventTime = time;
    notifyListeners();
  }

  void changeTime(TimeOfDay? time) {
    ChangeTime(time);
  }

  void onTabChange(int index) {
    tabIndex = index;
    notifyListeners();
  }

  Future<bool> createEvent(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final selectedCategory = AppCategory.categories[tabIndex];
      final user = FirebaseAuth.instance.currentUser;
      final formattedTime =
          eventTime != null ? eventTime!.format(context) : "";

      final event = EventModel(
        userId: user?.uid ?? "",
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        categoryId: selectedCategory.id,
        categoryTitle: selectedCategory.title,
        image: selectedCategory.image,
        eventDate: eventDate ?? DateTime.now(),
        eventTime: formattedTime,
        isFavorite: false,
      );

      await EventFirebaseService.addEvent(event);
      Toast.show(title: "Event created successfully!");
      return true;
    } catch (e) {
      Toast.show(title: e.toString(), typ: ToastTyp.error);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
