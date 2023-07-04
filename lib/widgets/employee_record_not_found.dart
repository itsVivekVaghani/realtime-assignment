import 'package:assignment/utills/app_text_theme.dart';
import 'package:assignment/utills/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeRecordNotFound extends StatefulWidget {
  const EmployeeRecordNotFound({Key? key}) : super(key: key);

  @override
  State<EmployeeRecordNotFound> createState() => _EmployeeRecordNotFoundState();
}

class _EmployeeRecordNotFoundState extends State<EmployeeRecordNotFound> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.empRecordNotFound,height: 218.w,width: 261.w),
          const SizedBox(height: 6,),
          Text("No employee records found",style: AppTextTheme.emptyWidgetTextTheme,),
        ],
      ),
    );
  }
}
