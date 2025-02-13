import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/extensions/screen_util_extension.dart';
import '../../../core/helpers/extensions/string_extensions.dart';
import '../../../core/theme/animated_fade_widget.dart';
import '../../../core/theme/app_colors.dart';

Future<Map<String, dynamic>?> showQueryParamsBottomSheet(
    BuildContext context, Map<String, dynamic> initialParams) async {
  return await showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return QueryParamsBottomSheet(initialParams: initialParams);
    },
  );
}

class QueryParamsBottomSheet extends StatefulWidget {
  final Map<String, dynamic> initialParams;
  const QueryParamsBottomSheet({super.key, required this.initialParams});

  @override
  QueryParamsBottomSheetState createState() => QueryParamsBottomSheetState();
}

class QueryParamsBottomSheetState extends State<QueryParamsBottomSheet> {
  late bool includeAdult;

  DateTime? selectedYear;

  @override
  void initState() {
    super.initState();
    includeAdult = widget.initialParams['include_adult'] ?? false;

    selectedYear = widget.initialParams['year'] != null
        ? DateTime.tryParse((widget.initialParams['year'] ?? '2025') + '-01-01')
        : null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.initialParams['year'].toString());
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: AppColors.blackPrimary1,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  "Include Adult".toSubTitle(fontSize: 20),
                  Spacer(),
                  Transform.scale(
                    scale: 1.r,
                    child: Switch(
                      value: includeAdult,
                      activeTrackColor: Colors.orange,
                      inactiveTrackColor: Colors.grey,
                      activeColor: Colors.yellow,
                      onChanged: (value) =>
                          setState(() => includeAdult = value),
                    ),
                  ),
                ],
              ),
            ),
            20.toSizedBox,
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: "Year".toSubTitle(fontSize: 20),
              ),
              subtitle: (selectedYear != null
                      ? DateFormat.y().format(selectedYear!)
                      : "Not specified")
                  .toSubTitle(),
              trailing: Icon(
                Icons.calendar_today,
                size: 30.r,
                color: Colors.white,
              ),
              onTap: _showCupertinoDatePicker,
            ),
            const SizedBox(height: 10),
            AnimatedFadeWidget(
                onTap: () {
                  final result = {
                    if (includeAdult) 'include_adult': includeAdult,
                    if (selectedYear != null)
                      'year': DateFormat.y().format(selectedYear!),
                  };
                  Navigator.pop(context, result);
                },
                child: Container(
                  width: double.infinity,
                  padding: REdgeInsets.symmetric(vertical: 15),
                  margin: REdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.goldenYellow,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: "Apply".toSubTitle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.blackPrimary1)),
                )),
            30.toSizedBox,
          ],
        ),
      ),
    );
  }

  void _showCupertinoDatePicker() {
    DateTime pickedYear = selectedYear ?? DateTime.now();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            children: [
              // Action buttons (Cancel & Done)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedYear = pickedYear;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Done',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedYear ?? DateTime.now(),
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime(2100),
                  onDateTimeChanged: (DateTime newDate) {
                    pickedYear = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
