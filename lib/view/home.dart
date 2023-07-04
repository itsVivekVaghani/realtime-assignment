import 'package:assignment/database/employee_database.dart';
import 'package:assignment/utills/app_text_theme.dart';
import 'package:assignment/utills/constants.dart';
import 'package:assignment/utills/date_util.dart';
import 'package:assignment/utills/snack_bar.dart';
import 'package:assignment/view/add_employee_details.dart';
import 'package:assignment/view/cubit/home_cubit.dart';
import 'package:assignment/view/edit_employee_details.dart';
import 'package:assignment/widgets/custom_floating_action_button.dart';
import 'package:assignment/widgets/employee_record_not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
        leading: SizedBox(),
        leadingWidth: 0,
      ),
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeeDetails(),
            ),
          );
        },
      ),
      body: BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()
          ..getEmployees(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                backgroundColor: Color(0xFF9D0027),
                content: Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),),);
            }
          },
          builder: (context, state) {
            if(state is HomeLoading){
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,),
              );
            }else if(state is HomeSuccess){
              final currentEmpList =
                  state.response.where((e) => e.toDate == null || (e.toDate!.isAfter(DateTime.now()))).toList();
              final previousEmpList = state.response
                  .where((e) => (e.toDate != null && e.toDate!.isBefore(DateTime.now())))
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    Expanded(
                      child: (currentEmpList.isEmpty && previousEmpList.isEmpty)
                          ? const EmployeeRecordNotFound()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (currentEmpList.isNotEmpty)
                            Container(
                              height: 56.h,
                              color: Colors.grey.withOpacity(0.12),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Current employees',
                                    style:
                                    AppTextTheme.heading16TextTheme.copyWith(
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (currentEmpList.isNotEmpty)
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (cont, index) =>
                                    Dismissible(
                                      key: Key(currentEmpList[index].id!.toString()),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) async {
                                        try {
                                          final model = await EmployeeDatabase
                                              .instance
                                              .delete(currentEmpList[index].id!);

                                          openSnackbar(
                                              snackMessage: "Employee data has been deleted",
                                              context: context,
                                              buttonText: "Undo",
                                              onPressed: () async {
                                                await EmployeeDatabase.instance.create(currentEmpList[index]);
                                                context.read<HomeCubit>().getEmployees();
                                              }
                                          );
                                          context.read<HomeCubit>().getEmployees();
                                        } catch (e) {
                                          openSnackbar(
                                            context: context,
                                            snackMessage: e.toString(),
                                          );
                                        }
                                      },
                                      background: Card(
                                        color: Colors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 18),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.delete_forever,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Delete",
                                                style: AppTextTheme.heading16TextTheme
                                                    .copyWith(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditEmployeeDetails(
                                                      model: currentEmpList[index]),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    currentEmpList[index].name,
                                                    style: AppTextTheme
                                                        .heading16TextTheme,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    currentEmpList[index].role,
                                                    style: AppTextTheme
                                                        .body14TextTheme
                                                        .copyWith(
                                                      color: const Color(0xff949C9E),
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15.h,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    currentEmpList[index].toDate !=
                                                        null
                                                        ? "${toStandardBritishDate(currentEmpList[index].fromDate)} - ${toStandardBritishDate(currentEmpList[index].toDate!)}"
                                                        : "From ${toStandardBritishDate(currentEmpList[index].fromDate)}",
                                                    style: AppTextTheme
                                                        .body14TextTheme
                                                        .copyWith(
                                                      color: const Color(0xff949C9E),
                                                      fontSize: 15.h,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 0.6,
                                              color: Colors.grey.withOpacity(0.4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                itemCount: currentEmpList.length,
                              ),
                            ),
                          if (previousEmpList.isNotEmpty)
                            Container(
                              height: 56.h,
                              color: Colors.grey.withOpacity(0.12),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Previous employees',
                                    style:
                                    AppTextTheme.heading16TextTheme.copyWith(
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (previousEmpList.isNotEmpty)
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (cont, index) => Dismissible(
                                  key: Key(previousEmpList[index].id!.toString()),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) async {
                                    try {
                                      final model = await EmployeeDatabase
                                          .instance
                                          .delete(previousEmpList[index].id!);

                                      openSnackbar(
                                          snackMessage: "Employee data has been deleted",
                                          context: context,
                                          buttonText: "Undo",
                                          onPressed: () async {
                                            print("dd");
                                            final result = await EmployeeDatabase.instance.create(previousEmpList[index]);
                                            context.read<HomeCubit>().getEmployees();
                                          }
                                      );
                                      context.read<HomeCubit>().getEmployees();
                                    } catch (e) {
                                      openSnackbar(
                                        snackMessage: e.toString(),
                                        context: context,
                                      );
                                    }
                                  },
                                  background: Card(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 18),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Delete",
                                            style: AppTextTheme.heading16TextTheme
                                                .copyWith(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditEmployeeDetails(
                                                  model: previousEmpList[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                previousEmpList[index].name,
                                                style: AppTextTheme
                                                    .heading16TextTheme,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                previousEmpList[index].role,
                                                style: AppTextTheme
                                                    .body14TextTheme
                                                    .copyWith(
                                                  color: const Color(0xff949C9E),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.h,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                previousEmpList[index].toDate !=
                                                    null
                                                    ? "${toStandardBritishDate(previousEmpList[index].fromDate)} - ${toStandardBritishDate(previousEmpList[index].toDate!)}"
                                                    : "From ${toStandardBritishDate(previousEmpList[index].fromDate)}",
                                                style: AppTextTheme
                                                    .body14TextTheme
                                                    .copyWith(
                                                  color: const Color(0xff949C9E),
                                                  fontSize: 15.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 0.6,
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                itemCount: previousEmpList.length,
                              ),
                            ),
                        ],
                      ),
                    ),
                  Container(
                    height: 50,
                    color: Colors.grey.withOpacity(0.12),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Swipe left to delete',
                          style: AppTextTheme.body16TextTheme.copyWith(
                            color: const Color(0xff949C9E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}



