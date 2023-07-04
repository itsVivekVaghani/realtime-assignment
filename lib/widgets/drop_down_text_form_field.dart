import 'package:assignment/utills/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MDropDownTextFormField extends StatefulWidget {
  final String name;
  final void Function()? onTap;
  const MDropDownTextFormField({
    Key? key, required this.name, this.onTap,
  }) : super(key: key);

  @override
  State<MDropDownTextFormField> createState() => _MDropDownTextFormFieldState();
}

class _MDropDownTextFormFieldState extends State<MDropDownTextFormField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.5, color: Color(0xffE5E5E5)),
          ),
          padding: EdgeInsets.fromLTRB(10, 9, 4, 9),
          child: Row(
            children: [
              Icon(
                Icons.work_outline,
                size: 22,
                color: Color(0xff1DA1F2),
              ),
              SizedBox(width: 16.w,),
              Expanded(
                child: Text(
                  widget.name.isEmpty ? "Select role" : widget.name,
                  style:widget.name.isEmpty?  AppTextTheme.fieldHintTextTheme : AppTextTheme.body16TextTheme,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 28,
                color: Color(0xff1DA1F2),
              ),
            ],
          )),
    );
  }
}


Future<String?> showRoleModelBottomSheet ({
  required BuildContext context
}) {
  return showModalBottomSheet<String?>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context,'Product Designer');
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("Product Designer",style: AppTextTheme.body16TextTheme,),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: Color(0xffF2F2F2),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context,'Flutter Developer');
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("Flutter Developer",style: AppTextTheme.body16TextTheme,),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: Color(0xffF2F2F2),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context,'QA Tester');
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("QA Tester",style: AppTextTheme.body16TextTheme,),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: Color(0xffF2F2F2),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context,'Product Owner');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 16),
                    child: Center(child: Text("Product Owner",style: AppTextTheme.body16TextTheme,)),
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}