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
  late TextEditingController languageController;
  late TextEditingController primaryReleaseYearController;

  DateTime? selectedYear;

  @override
  void initState() {
    super.initState();
    includeAdult = widget.initialParams['include_adult'] ?? false;
    languageController = TextEditingController(
        text: widget.initialParams['language'] ?? 'en-US');
    primaryReleaseYearController = TextEditingController(
        text: widget.initialParams['primary_release_year'] ?? '');
    selectedYear = widget.initialParams['year'] != null
        ? DateTime.tryParse(widget.initialParams['year'])
        : null;
  }

  @override
  void dispose() {
    languageController.dispose();
    primaryReleaseYearController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: AppColors.blackPrimary1,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: "Include Adult".toSubTitle(fontSize: 20),
              value: includeAdult,
              activeTrackColor: Colors.orange,
              inactiveTrackColor: Colors.grey,
              activeColor: Colors.yellow,
              onChanged: (value) => setState(() => includeAdult = value),
            ),
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
                color: Colors.white,
              ),
              onTap: () async {
                DateTime? pickedYear = await showDatePicker(
                  context: context,
                  initialDate: selectedYear ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                if (pickedYear != null) {
                  setState(() {
                    selectedYear = pickedYear;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            AnimatedFadeWidget(
                onTap: () {
                  final result = {
                    if (includeAdult) 'include_adult': includeAdult,
                    if (languageController.text.isNotEmpty)
                      'language': languageController.text,
                    if (primaryReleaseYearController.text.isNotEmpty)
                      'primary_release_year': primaryReleaseYearController.text,
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
}
