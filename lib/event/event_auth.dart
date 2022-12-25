import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uasd/event/event_rdb.dart';

import 'event_pref.dart';

class EventAuth{
  static Future<bool> register(String email, String password) async {
    try {
  final ucredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  if(ucredential.user?.uid!=null){
    EventRTDB.insertNewAccount(ucredential.user!.uid, email);
    Get.rawSnackbar(message: 'Registrasi Berhasil !');
    return true;
  }else{
     Get.rawSnackbar(message: 'Gagal Melakukan Registrasi');
     return false;
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('Password Terlalu Lemah');
    Get.rawSnackbar(message: 'Password Terlalu Lemah');
  } else if (e.code == 'email-already-in-use') {
    print('Akun Tersebut Sudah Ada & Terdaftar');
    Get.rawSnackbar(message: 'Email Sudah Terdaftar');
  }
  return false;
} catch (e) {
  print(e);
  Get.rawSnackbar(message: 'Gagal Melakukan Registrasi');
  return false;
}
  } 


static Future<String?> login(String email, String password) async {
   try {
  final ucredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
  if(ucredential.user?.uid != null ){
    EventPref.saveUid(ucredential.user!.uid);
    EventPref.saveEmail(email);
  Get.rawSnackbar(message: 'Login Berhasil !');
  return ucredential.user?.uid;
  }
  Get.rawSnackbar(message: 'Login Gagal ');
  return null;
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('Tidak Ditemukan akun pada email tersebut');
    Get.rawSnackbar(message: 'Tidak Ditemukan akun pada email tersebut');
  } else if (e.code == 'wrong-password') {
    print('Salah Pasword untuk Akun Tersebut');
  Get.rawSnackbar(message: 'Salah Pasword untuk Akun Tersebut');
  }
  return null;
}
}

static void resetPassword(String email){
  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  Get.rawSnackbar(message: 'Link Reset Sudah Dikirim Coba Cek');
}
}
