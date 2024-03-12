import 'package:flutter/material.dart';
import 'package:flutter3/firebase/firebase.dart';
import 'package:flutter3/firebase/service.dart';
import 'package:flutter3/pages/auth/login.dart';
import 'package:flutter3/service/service.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String userName = '';
  String phone = '';
  String password = '';
  bool loading = false;
  final _keyPhone = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate("signup"),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: translate('userName'),
                  prefixIcon: const Icon(Icons.person),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  contentPadding: const EdgeInsets.all(12.0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                onChanged: (value) {
                  userName = value;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Form(
                key: _keyPhone,
                child: TextFormField(
                  autocorrect: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: translate('phoneNumber'),
                    prefixIcon: const Icon(Icons.phone),
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.all(12.0),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{9,10}$)';
                    RegExp regExp = new RegExp(patttern);
                    if (value!.length > 8) {
                      if (value.length == 0) {
                        showToast('pleaseEnterValidMobileNumber');
                        return null;
                      } else if (value.toString().substring(0, 1) == "0" &&
                          value.toString().substring(1, 2) == "7" &&
                          value.length == 9) {
                        showToast('pleaseEnterValidMobileNumber');
                        return null;
                      } else if (value.toString().substring(0, 1) != "0" &&
                          value.toString().substring(0, 1) == "7" &&
                          value.length > 9) {
                        showToast('pleaseEnterValidMobileNumber');
                        return null;
                      } else if (value.toString().substring(0, 1) == "0" &&
                          value.toString().substring(1, 2) != "7") {
                        showToast('pleaseEnterValidMobileNumber');
                        return null;
                      } else if (value.toString().substring(0, 1) != "0" &&
                          value.toString().substring(0, 1) != "7") {
                        showToast('pleaseEnterValidMobileNumber');
                        return null;
                      } else if (!regExp.hasMatch(value)) {
                        showToast('pleaseEnterValidMobileNumber');
                        return null;
                      }
                    } else {
                      return null;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    phone = value;
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: translate('password'),
                  prefixIcon: const Icon(Icons.lock),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  contentPadding: const EdgeInsets.all(12.0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            InkWell(
              onTap: () {
                if (_keyPhone.currentState!.validate()) {
                  _keyPhone.currentState!.save();

                  if (phone == '' || password == '' || userName == '') {
                    showToast(translate("pleaseAddAllData"));
                  } else {
                    searchFirebaseDocument(
                            collectionName: "users",
                            query: phone,
                            where: "phone")
                        .then((serachVaue) {
                      print(serachVaue);
                      if (serachVaue.length == 0) {
                        //we can register
                        getFirebaseCollectionCount(collectionName: "users")
                            .then((count) {
                          var userData = {
                            'phone': phone,
                            'name': userName,
                            "password": password,
                            "image": "ssss",
                            'id': (count + 1).toString()
                          };
                          setFirebaseDocumentData(
                                  collectionName: "users", data: userData)
                              .then((value) {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const LoginPage(),
                              ),
                            );
                          });
                        });
                      } else {
                        //we can not register
                        showToast(translate("this phone is already exist"));
                      }
                    });

                    // check phone number
                    // count
                    // register
                    // login
                    /* setUserData(
                      phone: phone,
                      password: password,
                      name: userName,
                    ); */
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    color: Colors.deepPurple),
                alignment: Alignment.center,
                child: !loading
                    ? Text(
                        translate("signup"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    : const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${translate("haveAccount?")} ",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    translate("loginFromHere"),
                    style: const TextStyle(
                      // color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
