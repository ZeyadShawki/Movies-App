import 'package:equatable/equatable.dart';

class UserSignIn extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String phone;
  final String profileImage;
  const UserSignIn( {
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
   required this.profileImage,
  });

  @override
  List<Object> get props => [userName, email, password, phone,profileImage];
}
