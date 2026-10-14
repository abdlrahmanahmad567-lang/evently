import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../event/models/event_model.dart';

class Evantwidget extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const Evantwidget({
    super.key,
    required this.event,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        height: 193.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300),
          image: DecorationImage(
            image: AssetImage(
              event.image.isNotEmpty
                  ? event.image
                  : "assets/image/Sport.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: theme.scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat("dd").format(event.eventDate),
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat("MMM").format(event.eventDate),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: theme.scaffoldBackgroundColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onFavoriteTap,
                    child: Icon(
                      event.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
