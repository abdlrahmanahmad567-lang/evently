import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/cor/services/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus_pro/icons_plus_pro.dart';
import 'package:provider/provider.dart';

import '../../../cor/constant/app_Category.dart';
import '../../../cor/provider/app_provider.dart';
import '../../event/models/event_model.dart';
import '../../event/services/event_firebase_service.dart';
import '../manager/layout_provider.dart';
import '../widgets/evantWidget.dart';
import '../widgets/tab_Widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<LayoutProvider>(
          builder: (context, layoutProvider, child) {
            final selectedCategoryId = layoutProvider.tabIndex == 0
                ? 'all'
                : (layoutProvider.tabIndex - 1 < AppCategory.categories.length
                    ? AppCategory.categories[layoutProvider.tabIndex - 1].id
                    : 'all');

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Welcome Back ✨"),
                          Text(
                            (user?.displayName ?? "User").toUpperCase(),
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        appProvider.ChangeTheme(
                          appProvider.isDark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        );
                      },
                      child: Image.asset(
                        appProvider.isDark
                            ? "assets/image/moon.png"
                            : "assets/image/sun.png",
                        color: theme.primaryColor,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        appProvider.ChangeLang(
                          appProvider.langCode == 'en' ? 'ar' : 'en',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: theme.primaryColor,
                        ),
                        child: Text(
                          appProvider.langCode.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Category Tabs Bar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          layoutProvider.onTabChange(0);
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: TabWidgets(
                          title: 'All',
                          icon: Iconsax.menu_1_bold,
                          isSelected: layoutProvider.tabIndex == 0,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ...AppCategory.categories.asMap().entries.map((entry) {
                        int itemIndex = entry.key + 1;
                        var category = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: InkWell(
                            onTap: () {
                              layoutProvider.onTabChange(itemIndex);
                            },
                            borderRadius: BorderRadius.circular(16.r),
                            child: TabWidgets(
                              title: category.title,
                              icon: category.icon,
                              isSelected: layoutProvider.tabIndex == itemIndex,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Events List by Category
                Expanded(
                  child: StreamBuilder<List<EventModel>>(
                    stream: EventFirebaseService.getEventsStream(
                      categoryId: selectedCategoryId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: theme.primaryColor,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      final events = snapshot.data ?? [];

                      if (events.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.calendar_remove_outline,
                                size: 56.sp,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                layoutProvider.tabIndex == 0
                                    ? "No events found"
                                    : "No events in ${AppCategory.categories[layoutProvider.tabIndex - 1].title}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "Tap + to add an event here!",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: events.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return Evantwidget(
                            event: event,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouteName.eventDetailsScreen,
                                arguments: event,
                              );
                            },
                            onFavoriteTap: () async {
                              await EventFirebaseService.toggleFavorite(event);
                              Toast.show(
                                title: event.isFavorite
                                    ? "Added to favorites ❤️"
                                    : "Removed from favorites",
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
