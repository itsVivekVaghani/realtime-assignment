import 'dart:math';

import 'package:assignment/widgets/custom_calendar/calendar_date_picker2_config.dart';
import 'package:assignment/widgets/custom_calendar/calendar_date_picker2_with_action_buttons.dart';
import 'package:flutter/material.dart';

Future<List<DateTime?>?> showCustomCalendarDatePickerDialog({
  required BuildContext context,
  required CalendarDatePicker2WithActionButtonsConfig config,
  required Size dialogSize,
  required bool toDate,
  List<DateTime?> value = const [],
  BorderRadius? borderRadius,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  bool useSafeArea = true,
  Color? dialogBackgroundColor,
  RouteSettings? routeSettings,
  String? barrierLabel,
  TransitionBuilder? builder,
}) {
  var dialog = Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    backgroundColor: dialogBackgroundColor ?? Theme.of(context).canvasColor,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(10),
    ),
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      width: dialogSize.width,
      height: max(dialogSize.height, toDate ? 486 : 530),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalendarDatePicker2WithActionButtons(
            value: value,
            toDate: toDate,
            config: config.copyWith(openedFromDialog: true),
          ),
        ],
      ),
    ),
  );

  return showDialog<List<DateTime?>>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
  );
}
