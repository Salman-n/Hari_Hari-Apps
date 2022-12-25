import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_auth.dart';
import 'package:uasd/page/auth/register.dart';
import 'package:uasd/page/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Asset.colorBG,
                        padding: EdgeInsets.fromLTRB(30, 80, 30, 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Image.asset(
                                Asset.iconApp,
                                width: 135,
                                height: 135,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                controller: _controllerEmail,
                                validator: (value) =>
                                    value == '' ? "Tidak Boleh Kosong" : null,
                                cursorColor: Asset.colorPrimer,
                                decoration: InputDecoration(
                                  fillColor: Asset.colorSekunder,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Asset.colorPrimer,
                                      width: 2,
                                    ),
                                  ),
                                  hintText: 'email@gmail.com',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Asset.colorPrimer,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _controllerPassword,
                                validator: (value) =>
                                    value == '' ? "Tidak Boleh Kosong" : null,
                                cursorColor: Asset.colorPrimer,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Asset.colorSekunder,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Asset.colorPrimer,
                                      width: 2,
                                    ),
                                  ),
                                  hintText: '********',
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Asset.colorPrimer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Asset.colorPrimer,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print('Login...');
                               EventAuth.login(_controllerEmail.text,
                                      _controllerPassword.text)
                                  .then((uid) {
                                if (uid != null) {
                                  _controllerEmail.clear();
                                  _controllerPassword.clear();
                                  Future.delayed(const Duration(seconds: 2), () {
                                    Get.off(Home());
                                  });
                                }
                              });}
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Lupa Password?'),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  EventAuth.resetPassword(_controllerEmail.text);
                                }
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.resolveWith(
                                  (states) => const EdgeInsets.all(4),
                                ),
                              ),
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                  color: Asset.colorPrimer,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Belum Punya Akun?'),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                              onPressed: () =>Get.to(Register()) ,
                              style: ButtonStyle(
                                padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.all(4),
                                ),
                              ),
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                  color: Asset.colorPrimer,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
