import 'package:cloud_firestore/cloud_firestore.dart';

Future setUserData({name, phone, password}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  collectionReference
      .add({'name': name, 'password': password, "phone": phone});
  return "Done";
}
