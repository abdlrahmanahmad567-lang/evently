import 'package:evently/cor/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus_pro/icons_plus_pro.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../cor/constant/app_Category.dart';
import '../../../cor/widgets/custom_Buttom.dart';
import '../../layout/widgets/tab_Widgets.dart';
import '../maneger/edit_event_provider.dart';
import '../models/event_model.dart';

class EditEventScreen extends StatelessWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (context) => EditEventProvider(event: event),
      child: Scaffold(
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
          title: const Text("Edit event"),
        ),
        body: Consumer<EditEventProvider>(
          builder: (context, provider, child) {

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.asset(
                          AppCategory.categories[provider.tabIndex].image,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: AppCategory.categories.asMap().entries.map((entry) {
                          int itemIndex = entry.key;
                          var category = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: InkWell(
                              onTap: () {
                                provider.onTabChange(itemIndex);
                              },
                              borderRadius: BorderRadius.circular(16.r),
                              child: TabWidgets(
                                title: category.title,
                                icon: category.icon,
                                isSelected: itemIndex == provider.tabIndex,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: provider.titleController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter event title";
                        }
                        return null;
                      },
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      decoration: const InputDecoration(
                        hintText: "Event Title",
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: provider.descriptionController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter event description";
                        }
                        return null;
                      },
                      minLines: 4,
                      maxLines: 5,
                      textAlignVertical: TextAlignVertical.top,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      decoration: const InputDecoration(
                        hintText: "Event Description....",
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar_add_outline,
                          color: theme.primaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Event Date",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                              currentDate: DateTime.now(),
                              initialDate:
                                  provider.eventDate ?? DateTime.now(),
                              context: context,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 365)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            ).then((value) {
                              if (value != null) {
                                provider.changeDate(value);
                              }
                            });
                          },
                          child: Text(
                            provider.eventDate == null
                                ? "Choose date"
                                : DateFormat("MMM dd, yyyy")
                                    .format(provider.eventDate!),
                            style: TextStyle(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.timer_start_outline,
                          color: theme.primaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Event Time",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime:
                                  provider.eventTime ?? TimeOfDay.now(),
                            ).then((value) {
                              if (value != null) {
                                provider.ChangeTime(value);
                              }
                            });
                          },
                          child: Text(
                            provider.eventTime != null
                                ? provider.eventTime!.format(context)
                                : provider.event.eventTime.isNotEmpty
                                    ? provider.event.eventTime
                                    : "Choose time",
                            style: TextStyle(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    CustomButtom(
                      title: 'Update event',
                      isLoding: provider.isLoading,
                      onPressed: () async {
                        if (provider.formKey.currentState!.validate()) {
                          if (provider.eventDate == null) {
                            Toast.show(
                              title: "Please choose event date",
                              typ: ToastTyp.error,
                            );
                            return;
                          }
                          bool success = await provider.updateEvent(context);
                          if (success && context.mounted) {
                            Navigator.pop(context, provider.event);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
