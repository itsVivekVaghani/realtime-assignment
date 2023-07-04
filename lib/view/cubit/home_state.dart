part of 'home_cubit.dart';


abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  HomeSuccess({required this.response});

  final List<Employee> response;

  @override
  List<Object?> get props => [response];
}

// class AddPostSuccess extends HomeState {
//   AddPostSuccess({required this.response});
//
//   final dynamic response;
//
//   @override
//   List<Object?> get props => [response];
// }

class HomeFailure extends HomeState {
  HomeFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}