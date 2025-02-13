import 'package:equatable/equatable.dart';
 const noInternetConnection='No Internet connection';

 class Failure extends Equatable {
  final String message;
  final int? statusCode;
  const Failure(  {
    this.statusCode,
    required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message,super.statusCode});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});
}