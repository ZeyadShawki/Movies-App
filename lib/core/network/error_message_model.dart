
class ErrorMessageModel implements Exception  {
  String message;
  int statusCode;
  bool success;
  ErrorMessageModel({
    required this.message,
    required this.statusCode,
    required this.success
});
  factory ErrorMessageModel.fromJson(Map<String,dynamic> json)=>ErrorMessageModel(
      message: json['status_message'],
      statusCode: json['status_code'],
      success: json['success']);


}