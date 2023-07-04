import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeInitial> {
  AddEmployeeCubit()
      : super(AddEmployeeInitial(
            fromDate: DateTime.now(), toDate: null, role: ''));

  void setFromDate({
    required DateTime fromDate,
  }) =>
      emit(AddEmployeeInitial(
          role: state.role, toDate: state.toDate, fromDate: fromDate));

  void setToDate({
    required DateTime? toDate,
  }) =>
      emit(AddEmployeeInitial(
          role: state.role, toDate: toDate, fromDate: state.fromDate,));

  void setEmpRole({
    required String role,
  }) =>
      emit(AddEmployeeInitial(
        role: role, toDate: state.toDate, fromDate: state.fromDate,));

}
