import 'package:flutter/material.dart';

import '../../../cor/constant/app_Category.dart';
import '../../../cor/services/toast.dart';
import '../models/event_model.dart';
import '../services/event_firebase_service.dart';

class EditEventProvider extends ChangeNotifier {
  final EventModel event;
  late int tabIndex;
  late DateTime? eventDate;
  TimeOfDay? eventTime;
  final formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  bool isLoading = false;

  EditEventProvider({required this.event}) {
    titleController = TextEditingController(text: event.title);
    descriptionController = TextEditingController(text: event.description);
    eventDate = event.eventDate;

    // Parse time if possible or keep string
    eventTime = _parseTimeOfDay(event.eventTime);

    int index = AppCategory.categories.indexWhere(
      (c) => c.id.toLowerCase() == event.categoryId.toLowerCase(),
    );
    tabIndex = index != -1 ? index : 0;
  }

  TimeOfDay? _parseTimeOfDay(String timeStr) {
    if (timeStr.isEmpty) return null;
    try {
      final parts = timeStr.trim().split(RegExp(r'[:\s]'));
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        if (timeStr.toLowerCase().contains('pm') && hour < 12) {
          hour += 12;
        } else if (timeStr.toLowerCase().contains('am') && hour == 12) {
          hour = 0;
        }
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}
    return null;
  }

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

  Future<bool> updateEvent(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final selectedCategory = AppCategory.categories[tabIndex];
      final formattedTime = eventTime != null
          ? eventTime!.format(context)
          : event.eventTime;

      event.title = titleController.text.trim();
      event.description = descriptionController.text.trim();
      event.categoryId = selectedCategory.id;
      event.categoryTitle = selectedCategory.title;
      event.image = selectedCategory.image;
      event.eventDate = eventDate ?? event.eventDate;
      event.eventTime = formattedTime;

      await EventFirebaseService.updateEvent(event);
      Toast.show(title: "Event updated successfully!");
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
