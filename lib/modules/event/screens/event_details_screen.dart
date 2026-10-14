import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/cor/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus_pro/icons_plus_pro.dart';
import 'package:intl/intl.dart';

import '../models/event_model.dart';
import '../services/event_firebase_service.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventModel currentEvent;

  @override
  void initState() {
    super.initState();
    currentEvent = widget.event;
  }

  void _onDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("Delete Event"),
        content: const Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              if (currentEvent.id != null) {
                await EventFirebaseService.deleteEvent(currentEvent.id!);
                Toast.show(title: "Event deleted successfully");
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // If we have document ID, stream updates from Firestore
    if (currentEvent.id != null) {
      return StreamBuilder<DocumentSnapshot<EventModel>>(
        stream: EventFirebaseService.getEventStream(currentEvent.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.data() != null) {
            currentEvent = snapshot.data!.data()!;
          }
          return _buildContent(theme);
        },
      );
    }

    return _buildContent(theme);
  }

  Widget _buildContent(ThemeData theme) {
    return Scaffold(
      appBar: AppBar(
        leading: FittedBox(
          fit: BoxFit.scaleDown,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: theme.primaryColor),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: theme.primaryColor,
                size: 16.sp,
              ),
            ),
          ),
        ),
        title: const Text("Event details"),
        actions: [
          IconButton(
            icon: Icon(
              currentEvent.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: theme.primaryColor,
            ),
            onPressed: () async {
              await EventFirebaseService.toggleFavorite(currentEvent);
              Toast.show(
                title: currentEvent.isFavorite
                    ? "Added to favorites ❤️"
                    : "Removed from favorites",
              );
              if (mounted) {
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: Icon(
              Iconsax.edit_2_outline,
              color: theme.primaryColor,
            ),
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRouteName.editEventScreen,
                arguments: currentEvent,
              );
              if (result is EventModel && mounted) {
                setState(() {
                  currentEvent = result;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(
              Iconsax.trash_outline,
              color: Colors.red,
            ),
            onPressed: _onDelete,
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  currentEvent.image.isNotEmpty
                      ? currentEvent.image
                      : "assets/image/Sport.png",
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              currentEvent.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: theme.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      Iconsax.calendar_1_outline,
                      color: theme.primaryColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("d MMMM").format(currentEvent.eventDate),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        currentEvent.eventTime.isNotEmpty
                            ? currentEvent.eventTime
                            : "12:00 PM",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              currentEvent.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
