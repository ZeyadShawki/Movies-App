import 'package:shared_preferences/shared_preferences.dart';
// ignore: constant_identifier_names
const String Uid='Uid';
class AppPrefrenaces{
static SharedPreferences? sharedPreferences;
void init()async{
  sharedPreferences=await SharedPreferences.getInstance();
}

Future<void> saveUidofUser(String uid)async{
  sharedPreferences?.setString(Uid,uid);
}
Future<String> getUid()async{
  return sharedPreferences?.getString(Uid)??'';
}
Future<void> removeUid()async{
 await  sharedPreferences?.remove(Uid);
}

}