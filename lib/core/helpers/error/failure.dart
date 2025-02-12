import 'package:equatable/equatable.dart';
import 'package:movies/core/helpers/error/server_exception.dart';
 const noInternetConnection='No Internet connection';

 class Failure extends Equatable  {
  final String message;
  final int? statusCode;
  const Failure(  {
    this.statusCode,
    required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});

  factory ServerFailure.fromServerException(ServerException e) {
    return ServerFailure(message: e.toString(),statusCode: e.errorMessageModel.statusCode);
  }


  factory ServerFailure.noInternetConnection( ) {
    return ServerFailure(message: noInternetConnection,statusCode:408 );
  }
}

