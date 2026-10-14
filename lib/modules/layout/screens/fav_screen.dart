import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/cor/services/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../event/models/event_model.dart';
import '../../event/services/event_firebase_service.dart';
import '../widgets/evantWidget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar for Favorites
            TextFormField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim().toLowerCase();
                });
              },
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              decoration: InputDecoration(
                hintText: "Search for Event",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.sp,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SvgPicture.asset(
                    "assets/icon/search.svg",
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
              ),
            ),
            SizedBox(height: 16.h),

            // Favorites Stream List
            Expanded(
              child: StreamBuilder<List<EventModel>>(
                stream: EventFirebaseService.getFavoritesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

                  final allFavorites = snapshot.data ?? [];

                  final filteredFavorites = _searchQuery.isEmpty
                      ? allFavorites
                      : allFavorites.where((e) {
                          return e.title.toLowerCase().contains(_searchQuery) ||
                              e.description
                                  .toLowerCase()
                                  .contains(_searchQuery) ||
                              e.categoryTitle
                                  .toLowerCase()
                                  .contains(_searchQuery);
                        }).toList();

                  if (allFavorites.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 64.sp,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "No favorite events yet",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "Tap the heart icon on any event in Home to add it here!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (filteredFavorites.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 56.sp,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "No results found for \"$_searchQuery\"",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: filteredFavorites.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final event = filteredFavorites[index];
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
                          Toast.show(title: "Removed from favorites");
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
