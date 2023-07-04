import 'package:assignment/database/employee_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment/database/employee_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() :super(HomeInitial());

  Future<void> getEmployees() async {
    try {
      emit(HomeLoading());
      final response = await EmployeeDatabase.instance.getEmpList();
      emit(
        HomeSuccess(
          response: response,
        ),
      );
    } catch (e) {
      emit(HomeFailure(message: e.toString()));
    }
  }

}
