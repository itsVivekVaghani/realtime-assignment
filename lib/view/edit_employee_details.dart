import 'package:assignment/database/employee_database.dart';
import 'package:assignment/database/employee_model.dart';
import 'package:assignment/utills/app_text_theme.dart';
import 'package:assignment/utills/constants.dart';
import 'package:assignment/utills/date_util.dart';
import 'package:assignment/utills/snack_bar.dart';
import 'package:assignment/view/add_employee_cubit/add_employee_cubit.dart';
import 'package:assignment/view/home.dart';
import 'package:assignment/widgets/custom_calendar/calendar_date_picker2_config.dart';
import 'package:assignment/widgets/custom_calendar/custom_calendar_dialog.dart';
import 'package:assignment/widgets/drop_down_text_form_field.dart';
import 'package:assignment/widgets/rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditEmployeeDetails extends StatelessWidget {
  final Employee model;
  const EditEmployeeDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddEmployeeCubit>(
        create: (context) => AddEmployeeCubit(),
        child: _Content(model: model),
    );
  }
}




class _Content extends StatefulWidget {
  final Employee model;
  const _Content({Key? key, required this.model}) : super(key: key);

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    nameController.text = widget.model.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddEmployeeCubit>(
      create: (context) => AddEmployeeCubit()..setEmpRole(role: widget.model.role)..setToDate(toDate: widget.model.toDate)..setFromDate(fromDate:  widget.model.fromDate),
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          title: const Text("Edit Employee Details"),
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  final model = await EmployeeDatabase
                      .instance
                      .delete(widget.model.id!);
                  openSnackbar(
                    snackMessage: "Employee data has been deleted",
                    context: context,
                    buttonText: "Undo",
                    onPressed: () async {
                      await EmployeeDatabase.instance.create(widget.model);
                    }
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Home(),
                      )
                  );
                } catch (e) {
                  openSnackbar(
                    context: context,
                    snackMessage: e.toString(),
                  );
                }
              },
              icon: Icon(
                Icons.delete_forever_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: BlocBuilder<AddEmployeeCubit,AddEmployeeInitial>(
    builder: (context, state) => Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    focusNode: focusNode,
                    validator: (val){
                      if(val == null){
                        return "Please enter name";
                      }else if(val.isEmpty){
                        return "Please enter name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintStyle: AppTextTheme.fieldHintTextTheme,
                      hintText: "Employee name",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 14),
                      prefixIcon: const Icon(
                        Icons.person_3_outlined,
                        size: 22,
                        color: Color(0xff1DA1F2),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                        BorderSide(width: 1.5, color: Color(0xffE5E5E5)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                        BorderSide(width: 1.5, color: Color(0xffE5E5E5)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                        BorderSide(width: 1.5, color: Color(0xffE5E5E5)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide:
                        BorderSide(width: 1.5, color: Color(0xffE5E5E5)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  MDropDownTextFormField(
                    name: state.role,
                    onTap: ()async {
                      focusNode.unfocus();
                      final result = await showRoleModelBottomSheet(context: context);
                      if(result != null){
                        BlocProvider.of<AddEmployeeCubit>(context).setEmpRole(role: result);
                      }
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: () async {
                          const dayTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
                          List<DateTime?> singleDatePickerValueWithDefaultValue = [
                            state.fromDate,
                          ];
                          final config = CalendarDatePicker2WithActionButtonsConfig(
                            dayTextStyle: dayTextStyle,

                            calendarType: CalendarDatePicker2Type.single,
                            selectedDayHighlightColor: primaryColor,
                            closeDialogOnCancelTapped: true,
                            firstDayOfWeek: 1,
                            weekdayLabelTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            controlsTextStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            centerAlignModePicker: true,
                            customModePickerIcon: const SizedBox(),
                            selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
                          );
                          final values = await showCustomCalendarDatePickerDialog(
                            context: context,
                            config: config,
                            toDate: false,
                            dialogSize: const Size(325, 400),
                            borderRadius: BorderRadius.circular(15),
                            value: singleDatePickerValueWithDefaultValue,
                            dialogBackgroundColor: Colors.white,
                          );
                          if (values != null) {
                            singleDatePickerValueWithDefaultValue = values;
                            BlocProvider.of<AddEmployeeCubit>(context).setFromDate(fromDate: values.first ?? DateTime.now());
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1.5, color: Color(0xffE5E5E5)),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 12, 4, 12),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 22,
                                  color: Color(0xff1DA1F2),
                                ),
                                SizedBox(width: 16.w,),
                                Expanded(
                                  child: Text(
                                    toStandardBritishDate(state.fromDate),
                                    style: AppTextTheme.body16TextTheme,
                                  ),
                                ),
                              ],
                            )),
                      ),) ,
                      SizedBox(width: 16.w,),
                      const Icon(Icons.arrow_right_alt),
                      SizedBox(width: 16.w,),
                      Expanded(child: InkWell(
                        onTap: () async {
                          const dayTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
                          List<DateTime?> singleDatePickerValueWithDefaultValue0 = [
                            state.toDate,
                          ];
                          final config = CalendarDatePicker2WithActionButtonsConfig(
                            dayTextStyle: dayTextStyle,

                            calendarType: CalendarDatePicker2Type.single,
                            selectedDayHighlightColor: primaryColor,
                            closeDialogOnCancelTapped: true,
                            firstDayOfWeek: 1,
                            weekdayLabelTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            controlsTextStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            centerAlignModePicker: true,
                            customModePickerIcon: const SizedBox(),
                            selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
                          );
                          final values = await showCustomCalendarDatePickerDialog(
                            context: context,
                            config: config,
                            toDate: true,
                            dialogSize: const Size(325, 400),
                            borderRadius: BorderRadius.circular(15),
                            value: singleDatePickerValueWithDefaultValue0,
                            dialogBackgroundColor: Colors.white,
                          );
                          if (values != null) {
                            singleDatePickerValueWithDefaultValue0 = values;
                            BlocProvider.of<AddEmployeeCubit>(context).setToDate(toDate: values.first);
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1.5, color: Color(0xffE5E5E5)),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 12, 4, 12),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 22,
                                  color: Color(0xff1DA1F2),
                                ),
                                SizedBox(width: 16.w,),
                                Expanded(
                                  child: Text(
                                    state.toDate == null ?  "No date" : toStandardBritishDate(state.toDate!),
                                    style: state.toDate == null ? AppTextTheme.fieldHintTextTheme : AppTextTheme.body16TextTheme ,
                                  ),
                                ),
                              ],
                            )),
                      ),) ,
                    ],
                  )


                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 2,
              color: dividerColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RectangleButton(
                    text: "Cancel",
                    textColor: buttonBgColor,
                    backgroundColor: const Color(0xffEDF8FF),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 16.w,),
                  RectangleButton(
                    text: "Save",
                    onPressed: ()async{
                      focusNode.unfocus();
                      if (_formKey.currentState?.validate() ?? false){
                        if(state.role.isNotEmpty){
                          try {
                            final emp = Employee(
                              id: widget.model.id,
                              name: nameController.text,
                              role: state.role,
                              toDate: state.toDate,
                              fromDate: state.fromDate,
                            );
                            final model = await EmployeeDatabase.instance.update(emp);
                            openSnackbar(
                              snackMessage: "Employee data has been updated",
                              context: context,
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Home(),
                                )
                            );
                          }catch (e) {
                            openSnackbar(
                              context: context,
                              snackMessage: e.toString(),
                            );
                          }

                        }else {
                          openSnackbar(
                            snackMessage: "Please select role",
                            context: context,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),)


        ),
      ),
    );
  }
}
