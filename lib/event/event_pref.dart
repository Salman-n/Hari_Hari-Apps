import 'package:shared_preferences/shared_preferences.dart';

class EventPref{
  static void saveUid(String uid) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('uid', uid);
  }

  static Future<String?> getUid() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getString('uid');
  }

   static void saveEmail(String email) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('email', email);
  }

  static Future<String?> getEmail() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getString('email');
  }

  static void clear() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}