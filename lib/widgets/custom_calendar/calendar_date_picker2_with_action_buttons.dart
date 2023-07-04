import 'package:assignment/utills/app_text_theme.dart';
import 'package:assignment/utills/constants.dart';
import 'package:assignment/utills/date_util.dart';
import 'package:assignment/widgets/custom_calendar/calendar_date_picker2.dart';
import 'package:assignment/widgets/custom_calendar/calendar_date_picker2_config.dart';
import 'package:assignment/widgets/rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CalendarDatePicker2WithActionButtons extends StatefulWidget {
  const CalendarDatePicker2WithActionButtons({
    required this.value,
    required this.toDate,
    required this.config,
    this.onValueChanged,
    this.onDisplayedMonthChanged,
    this.onCancelTapped,
    this.onOkTapped,
    Key? key,
  }) : super(key: key);

  final bool toDate;

  final List<DateTime?> value;

  /// Called when the user taps 'OK' button
  final ValueChanged<List<DateTime?>>? onValueChanged;

  /// Called when the user navigates to a new month/year in the picker.
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  /// The calendar configurations including action buttons
  final CalendarDatePicker2WithActionButtonsConfig config;

  /// The callback when cancel button is tapped
  final Function? onCancelTapped;

  /// The callback when ok button is tapped
  final Function? onOkTapped;

  @override
  State<CalendarDatePicker2WithActionButtons> createState() =>
      _CalendarDatePicker2WithActionButtonsState();
}

class _CalendarDatePicker2WithActionButtonsState
    extends State<CalendarDatePicker2WithActionButtons> {
  List<DateTime?> _values = [];
  List<DateTime?> _editCache = [];
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    _values = widget.value;
    _editCache = widget.value;
    initialDate = widget.value.first ?? DateTime.now();
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant CalendarDatePicker2WithActionButtons oldWidget) {
    var isValueSame = oldWidget.value.length == widget.value.length;

    if (isValueSame) {
      for (var i = 0; i < oldWidget.value.length; i++) {
        var isSame = (oldWidget.value[i] == null && widget.value[i] == null) ||
            DateUtils.isSameDay(oldWidget.value[i], widget.value[i]);
        if (!isSame) {
          isValueSame = false;
          break;
        }
      }
    }

    if (!isValueSame) {
      _values = widget.value;
      _editCache = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(widget.toDate)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: RectangleButton(
                        onPressed: () {

                          setState(() {
                            _editCache.first = null;
                            _values = _editCache;
                            widget.onValueChanged?.call(_values);
                            widget.onOkTapped?.call();
                          });
                        },
                        backgroundColor: Color(0xffEDF8FF),
                        text:  "No Date",
                        textColor:  primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: RectangleButton(
                        onPressed: () {
                          setState(() {
                            _editCache.first = DateTime.now();
                            _values = _editCache;
                            widget.onValueChanged?.call(_values);
                            widget.onOkTapped?.call();
                          });
                        },
                        backgroundColor: compareDate(_editCache.first,DateTime.now()) ? primaryColor : Color(0xffEDF8FF),
                        text:  "Today",
                        textColor: compareDate(_editCache.first,DateTime.now()) ? Colors.white : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        if(!widget.toDate)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: RectangleButton(
                        onPressed: () {

                          setState(() {
                            _editCache.first = DateTime.now();
                            _values = _editCache;
                            widget.onValueChanged?.call(_values);
                            widget.onOkTapped?.call();
                          });
                        },
                        backgroundColor: compareDate(_editCache.first!,DateTime.now()) ? primaryColor : Color(0xffEDF8FF),
                        text:  "Today",
                        textColor: compareDate(_editCache.first!,DateTime.now()) ? Colors.white : primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: RectangleButton(
                        onPressed: () {
                          setState(() {
                            _editCache.first =
                                initialDate.add(Duration(days: 1));
                            _values = _editCache;
                            widget.onValueChanged?.call(_values);
                            widget.onOkTapped?.call();
                          });
                        },
                        backgroundColor: compareDate(initialDate.add(Duration(days: 1)),_editCache.first!) ? primaryColor : Color(0xffEDF8FF),
                        textColor: compareDate(initialDate.add(Duration(days: 1)),_editCache.first!) ? Colors.white : primaryColor,
                        text:
                        "Next ${DateFormat('EEEE').format(initialDate.add(Duration(days: 1)))}",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: RectangleButton(
                        onPressed: () {
                          setState(() {
                            _editCache.first =
                                initialDate.add(Duration(days: 2));
                            _values = _editCache;
                            widget.onValueChanged?.call(_values);
                            widget.onOkTapped?.call();
                          });
                        },
                        backgroundColor: compareDate(initialDate.add(Duration(days: 2)),_editCache.first!) ? primaryColor : Color(0xffEDF8FF),
                        textColor: compareDate(initialDate.add(Duration(days: 2)),_editCache.first!) ? Colors.white : primaryColor,
                        text:
                        "Next ${DateFormat('EEEE').format(initialDate.add(Duration(days: 2)))}",
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: RectangleButton(
                        onPressed: () {
                          setState(() {
                            _editCache.first =
                                initialDate.add(Duration(days: 7));
                            _values = _editCache;
                            widget.onValueChanged?.call(_values);
                            widget.onOkTapped?.call();
                          });
                        },
                        text: "After 1 week",
                        backgroundColor: compareDate(initialDate.add(Duration(days: 7)),_editCache.first!) ? primaryColor : Color(0xffEDF8FF),
                        textColor: compareDate(initialDate.add(Duration(days: 7)),_editCache.first!) ? Colors.white : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        MediaQuery.removePadding(
          context: context,
          child: CustomCalendarDatePicker(
            value: [..._editCache],
            config: widget.config,
            onValueChanged: (values) {
              setState(() {
                _editCache = values;
              });
            },
            onDisplayedMonthChanged: widget.onDisplayedMonthChanged,
          ),
        ),
        SizedBox(height: widget.config.gapBetweenCalendarAndButtons ?? 10),
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 1.5,
              color: dividerColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 16.w,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 22,
                        color: Color(0xff1DA1F2),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        toStandardBritishDate(
                            _editCache.first ?? DateTime.now()),
                        style: AppTextTheme.body16TextTheme,
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  RectangleButton(
                    text: "Cancel",
                    textColor: buttonBgColor,
                    backgroundColor: Color(0xffEDF8FF),
                    onPressed: () {
                      setState(() {
                        _editCache = _values;
                        widget.onCancelTapped?.call();
                        if ((widget.config.openedFromDialog ?? false) &&
                            (widget.config.closeDialogOnCancelTapped ?? true)) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RectangleButton(
                    text: "Save",
                    onPressed: () {
                      setState(() {
                        _values = _editCache;
                        widget.onValueChanged?.call(_values);
                        widget.onOkTapped?.call();
                        if ((widget.config.openedFromDialog ?? false) &&
                            (widget.config.closeDialogOnOkTapped ?? true)) {
                          Navigator.pop(context, _values);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     // Text(((_editCache.first ?? DateTime.now()).add(Duration(days: 1)) ).toUtc().toString()),
        //     _buildCancelButton(Theme.of(context).colorScheme, localizations),
        //     if ((widget.config.gapBetweenCalendarAndButtons ?? 0) > 0)
        //       SizedBox(width: widget.config.gapBetweenCalendarAndButtons),
        //     _buildOkButton(Theme.of(context).colorScheme, localizations),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildCancelButton(
      ColorScheme colorScheme, MaterialLocalizations localizations) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => setState(() {
        _editCache = _values;
        widget.onCancelTapped?.call();
        if ((widget.config.openedFromDialog ?? false) &&
            (widget.config.closeDialogOnCancelTapped ?? true)) {
          Navigator.pop(context);
        }
      }),
      child: Container(
        padding: widget.config.buttonPadding ??
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: widget.config.cancelButton ??
            Text(
              localizations.cancelButtonLabel.toUpperCase(),
              style: widget.config.cancelButtonTextStyle ??
                  TextStyle(
                    color: widget.config.selectedDayHighlightColor ??
                        colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
      ),
    );
  }

  Widget _buildOkButton(
      ColorScheme colorScheme, MaterialLocalizations localizations) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => setState(() {
        _values = _editCache;
        widget.onValueChanged?.call(_values);
        widget.onOkTapped?.call();
        if ((widget.config.openedFromDialog ?? false) &&
            (widget.config.closeDialogOnOkTapped ?? true)) {
          Navigator.pop(context, _values);
        }
      }),
      child: Container(
        padding: widget.config.buttonPadding ??
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: widget.config.okButton ??
            Text(
              localizations.okButtonLabel.toUpperCase(),
              style: widget.config.okButtonTextStyle ??
                  TextStyle(
                    color: widget.config.selectedDayHighlightColor ??
                        colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
      ),
    );
  }
}


bool compareDate(DateTime? date1,DateTime? date2){
  if(date1 != null && date2 != null){
    if(date1.day == date2.day && date1.month == date2.month && date1.year == date2.year){
      return true;
    }else {
      return false;
    }
  }else {
    return false;
  }

}