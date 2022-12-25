import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uasd/config/asset.dart';
import 'package:uasd/firebase_options.dart';
import 'package:uasd/page/auth/login.dart';
import 'package:uasd/page/home.dart';

import 'event/event_pref.dart';


Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Asset.colorPrimer,
      ),
      home: FutureBuilder(future: EventPref.getUid(), builder: (BuildContext context, AsyncSnapshot<String?> snapshot) { 
        return snapshot.data == null? Login() : const Home();
       },
       ),
      );
  }
}