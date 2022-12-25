import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_auth.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/page/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
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
                              print('Register...');
                             
                             EventAuth.register(_controllerEmail.text,
                                      _controllerPassword.text)
                                  .then((success) {
                                if (success) {
                                  _controllerEmail.clear();
                                  _controllerPassword.clear();
                                }
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                            child: Text(
                              'Daftar',
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
                          Text('Sudah ada akun?'),
                          SizedBox(
                            height: 30,
                            width: 70,
                            child: TextButton(
                              onPressed: () => Get.back(),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.all(4),
                                ),
                              ),
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  color: Asset.colorPrimer,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
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
