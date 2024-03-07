import 'package:cloud_firestore/cloud_firestore.dart';

Future setUserData({name, email, password}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  collectionReference
      .add({'name': "ABD", 'password': '123456', "phoneNumber": "07878787"});
  return "Done";
}
