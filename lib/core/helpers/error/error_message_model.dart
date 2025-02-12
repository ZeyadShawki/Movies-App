import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int? statusCode;
  final String? message;
  final bool? success;

  const ErrorMessageModel({
     this.statusCode=400,
     this.message,
     this.success,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      statusCode: json["status_code"],
      message: json["message"],
      success: json["success"],
    );
  }

  @override
  List<Object?> get props => [
        message,
        success,
      ];
}
