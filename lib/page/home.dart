import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_auth.dart';
import 'package:uasd/event/event_pref.dart';
import 'package:uasd/page/auth/login.dart';
import 'package:uasd/page/ct/fragment_catet.dart';
import 'package:uasd/page/dy/fragment_diary.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          titleSpacing: 0,
          
          title: const Text("Hari-Hari App"),
          backgroundColor: Asset.colorBG,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'DIARY'),
              Tab(text: 'NOTE'),
            ],
            labelColor: Color.fromARGB(255, 255, 255, 255)),

          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.white),
          //   onPressed: () {
          //     Get.to(Login());
          //     EventPref.clear();
          //   },
          // ),
        ),
        body: TabBarView(children:[
          FragmDiary(),
          FragmCatet(),
        ]),
      ),
    );
  }

  Widget buildDrawer(){
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Asset.colorBG),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(Asset.iconApp, width: 95, height: 95, fit: BoxFit.contain,),
              FutureBuilder(
                  future: EventPref.getEmail(),
                  builder: (context, AsyncSnapshot<String?> snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
            ],
          ),
         ),
         ListTile(
          onTap: () {
            EventPref.getEmail().then((email) {
              EventAuth.resetPassword(email!);
            });
            
          },
          leading: Icon(Icons.edit, color: Asset.colorPrimer,),
          title: const Text('Reset Password', style: TextStyle(fontSize: 15),),
          dense: true,
         ),
         const Divider(
          height: 1, thickness: 1,
         ),
          ListTile(
            onTap: () {
               Get.to(Login());
               EventPref.clear();
            },
          leading: Icon(Icons.logout_outlined, color: Asset.colorPrimer,),
          title: const Text('Keluar', style: TextStyle(fontSize: 15),),
          dense: true,
         ),
         const Divider(
          height: 1, thickness: 1,
         )
        ],
      ),
    );
  }
}
