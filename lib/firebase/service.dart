import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter3/shared/shared.dart';

Future getFirebaseCollectionData({collectionName}) async {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    QuerySnapshot querySnapshot = await collection.get();
    List idsData = querySnapshot.docs.map((doc) => doc.reference.id).toList();

    List data = querySnapshot.docs.map((doc) => doc.data()).toList();
    List allData = [];
    for (var i = 0; i < idsData.length; i++) {
      allData.insert(i, {'id': idsData[i], 'data': data[i]});
    }
    return allData;
  } catch (e) {
    print("a7a Collection");
    print(e);
  }
}

Future getFirebaseCollectionDataLimit({collectionName, limit, orderBy}) async {
  List<DocumentSnapshot> documentList = [];
  if (lastQuery == null) {
    documentList = (await FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy(orderBy, descending: true)
            .limit(limit)
            .get())
        .docs;
    lastQuery = documentList;
  } else {
    documentList = (await FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy(orderBy, descending: true)
            .startAfterDocument(lastQuery![lastQuery!.length - 1])
            .limit(limit)
            .get())
        .docs;
    lastQuery = documentList;
  }

  try {
    List allData = [];
    for (var i = 0; i < documentList.length; i++) {
      allData.insert(
          i, {'id': documentList[i].id, 'data': documentList[i].data()});
    }
    return allData;
  } catch (e) {
    print("a7a Collection");
    print(e);
  }
}

Future getFirebaseCollectionCount({collectionName}) async {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    QuerySnapshot querySnapshot = await collection.get();
    List idsData = querySnapshot.docs.map((doc) => doc.reference.id).toList();

    return idsData.length;
  } catch (e) {
    print("a7a Collection");
    print(e);
  }
}

Future getFirebaseDocumentData({documentId, collectionName}) async {
  final DocumentReference document =
      FirebaseFirestore.instance.collection(collectionName).doc(documentId);
  try {
    dynamic data;
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      data = {'data': snapshot.data(), 'id': snapshot.id};
    });
    return data;
  } catch (e) {
    print("a7a Get");
    print(e);
  }
}

Future setFirebaseDocumentData({data, collectionName}) async {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    await collection.add(data);
    return 'success';
  } catch (e) {
    print("a7a Set");
    print(e);
  }
}

Future deleteFirebaseDocumentData({id, collectionName}) async {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    await collection.doc(id).delete();
    return 'success';
  } catch (e) {
    print("a7a Delete");
    print(e);
  }
}

Future updateFirebaseDocumentData({id, data, collectionName}) async {
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    await collection.doc(id).update(data);
    return 'success';
  } catch (e) {
    print("a7a Update");
    print(e);
  }
}

Future searchFirebaseDocument({collectionName, query, where}) async {
  print("collectionName $collectionName");
  print(query);

  try {
    List<DocumentSnapshot> documentList;
    documentList = (await FirebaseFirestore.instance
            .collection(collectionName)
            .where(where, isEqualTo: query)
            .get())
        .docs;
    List allData = [];
    for (var i = 0; i < documentList.length; i++) {
      allData.insert(
          i, {'id': documentList[i].id, 'data': documentList[i].data()});
    }

    return allData;
  } catch (e) {
    print("a7a Search");
    print(e);
  }
}

Future searchFirebaseInArrayDocument({collectionName, query, where}) async {
  try {
    List<DocumentSnapshot> documentList;
    documentList = (await FirebaseFirestore.instance
            .collection(collectionName)
            .where(where, arrayContains: query)
            .get())
        .docs;

    List allData = [];
    for (var i = 0; i < documentList.length; i++) {
      allData.insert(
          i, {'id': documentList[i].id, 'data': documentList[i].data()});
    }

    return allData;
  } catch (e) {
    print("a7a Search");
    print(e);
  }
}

Future loginFirebase({phone, password}) async {
  try {
    List<DocumentSnapshot> documentList;
    documentList = (await FirebaseFirestore.instance
            .collection("users")
            .where("phone", isEqualTo: phone)
            .where('password', isEqualTo: password)
            .get())
        .docs;

    return documentList.isEmpty
        ? []
        : {'data': documentList[0].data(), 'id': documentList[0].id};
  } catch (e) {
    print("a7a Search");
    print(e);
  }
}
