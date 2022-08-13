import 'dart:convert';
import 'dart:io';

import 'package:doniya/fcm/call_notification.dart';
import 'package:doniya/helpers/commens.dart';
import 'package:doniya/helpers/conatans.dart';
import 'package:doniya/helpers/loading.dart';
import 'package:doniya/models/adds_model.dart';
import 'package:doniya/models/sub_catyegories/sub_categories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../../../../app-with-api/models/add_model.dart';

class AddsProviders extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool isLoading = false;

  // Future<String> uploadFile(File _image) async {
  //   StorageReference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('posts/${_image.path}');
  //   StorageUploadTask uploadTask = storageReference.putFile(_image);
  //   await uploadTask.onComplete;
  //
  //   return await storageReference.getDownloadURL();
  // }

  addAdds(
      {required String userId,
      required String typeId,
      required String name,
      required String desc,
      required List<XFile> images,
      required bool isImages,
      required String location,
      required String phone,
      required String title,
      required String status,
      required String phoneWhat,
      required String textEnglish,
      required String country,
      required BuildContext context,
      required String table}) async {
    isLoading = true;
    print(isLoading);
    notifyListeners();
    CollectionReference users = FirebaseFirestore.instance.collection(table);
    CollectionReference userData = FirebaseFirestore.instance
        .collection("DataUsers")
        .doc(userId)
        .collection("adds");

    if (isImages) {
      await Future.wait(images.map((_image) => uploadFile(_image)))
          .then((value) => {
                users.add({
                  "userid": userId,
                  "typeId": typeId,
                  "name": name,
                  "title": title,
                  "phoneWhat": phoneWhat,
                  "textEnglish": textEnglish,
                  "desc": desc,
                  "isImages": isImages,
                  "images": value,
                  "location": location,
                  "phone": phone,
                  "status": status,
                  "country": country,
                  "time": Timestamp.now(),
                }),
                userData.add({
                  "userid": userId,
                  "typeId": typeId,
                  "name": name,
                  "title": title,
                  "phoneWhat": phoneWhat,
                  "textEnglish": textEnglish,
                  "desc": desc,
                  "images": value,
                  "isImages": isImages,
                  "location": location,
                  "phone": phone,
                  "status": status,
                  "country": country,
                  "time": Timestamp.now(),
                }).then((value) {
                  isLoading = false;
                  print(isLoading);
                  final snackBar = SnackBar(
                    content: const Text('تم اضافة الاعلان'),
                    action: SnackBarAction(
                      label: "",
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  sendNotificationCubit(
                      title: "",
                      subject: "تم اضافة اعلان في الاعلانات المعلقة");
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).pop();
                  notifyListeners();
                })
              });
    } else {
      users.add({
        "userid": userId,
        "typeId": typeId,
        "name": name,
        "title": title,
        "phoneWhat": phoneWhat,
        "textEnglish": textEnglish,
        "desc": desc,
        "isImages": isImages,
        "images": images,
        "location": location,
        "phone": phone,
        "status": status,
        "country": country,
        "time": Timestamp.now(),
      });

      userData.add({
        "userid": userId,
        "typeId": typeId,
        "name": name,
        "title": title,
        "phoneWhat": phoneWhat,
        "textEnglish": textEnglish,
        "desc": desc,
        "images": images,
        "isImages": isImages,
        "location": location,
        "phone": phone,
        "status": status,
        "country": country,
        "time": Timestamp.now(),
      }).then((value) {
        isLoading = false;
        print(isLoading);
        final snackBar = SnackBar(
          content: const Text('تم اضافة الاعلان'),
          action: SnackBarAction(
            label: "",
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        sendNotificationCubit(
            title: "", subject: "تم اضافة اعلان في الاعلانات المعلقة");
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pop();
        notifyListeners();
      });
    }

    // String fileName = basename(image.path);

/*    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("uploads/$fileName")
        .putFile(File(image.path));*/

    /*   task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      if (snapshot.state == TaskState.success) {
        //

        snapshot.ref.getDownloadURL().then((value) => {
              users.add({
                "userid": userId,
                "typeId": typeId,
                "name": name,
                "title": title,
                "phoneWhat": phoneWhat,
                "textEnglish": textEnglish,
                "desc": desc,
                "image": value,
                "location": location,
                "phone": phone,
                "status": status,
                "time": Timestamp.now(),
              }),
              userData.add({
                "userid": userId,
                "typeId": typeId,
                "name": name,
                "title": title,
                "phoneWhat": phoneWhat,
                "textEnglish": textEnglish,
                "desc": desc,
                "image": value,
                "location": location,
                "phone": phone,
                "status": status,
                "time": Timestamp.now(),
              })
            });
        isLoading = false;
        print(isLoading);
        final snackBar = SnackBar(
          content: const Text('تم اضافة الاعلان'),
          action: SnackBarAction(
            label: "",
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pop();
        notifyListeners();
      }
    }, onError: (e) {
      isLoading = false;
      notifyListeners();
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });*/
    notifyListeners();
  }

  Future<String> uploadFile(XFile _image) async {
    String fileName = basename(_image.path);

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("uploads/$fileName")
        .putFile(File(_image.path));

    // StorageReference storageReference = FirebaseStorage.instance
    //     .ref()
    //     .child('posts/${_image.path}');
    // StorageUploadTask uploadTask = storageReference.putFile(_image);
    // await uploadTask.onComplete;
    var dowurl = await (await task).ref.getDownloadURL();

    return dowurl.toString();
  }

  List<SubCategoModel> listSc = [];
  List<String> listHCNames = [];
  bool isLoadCh = false;

  getHomeCategory(String tableName, String orderBy) {
    listSc = [];
    listHCNames = [];
    isLoadCh = true;
    notifyListeners();

    FirebaseFirestore.instance
        .collection(tableName)
        .where("field", isEqualTo: orderBy)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listSc.add(SubCategoModel.fromJson(doc.data() as Map<String, dynamic>));

        print(listSc.length);
      });
      for (var element in listSc) {
        listHCNames.add(element.name!);
      }
      isLoadCh = false;
      notifyListeners();
    });
    notifyListeners();
  }

  List<AddModel> listSearch = [];
  bool isSearching = false;

  /*getDataSearch(String name, String nameTable) async {
    listSearch = [];
    isSearching = true;
    notifyListeners();
    CollectionReference userData =
        FirebaseFirestore.instance.collection("adds");
    await userData.where("name", isEqualTo: name).get().then((value) {
      value.docs.forEach((doc) {
        listSearch.add(AddModel.fromJson(doc.data() as Map<dynamic, dynamic>));
        print(listSearch.length);
      });
      isSearching = false;
      notifyListeners();
    });
  }
*/
  List<String> listHome = [];

  getHomeCategoryList(nameTables) {
    listHome = [];
    notifyListeners();
    FirebaseFirestore.instance
        .collection(nameTables)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        listHome.add(doc["name"]);
        notifyListeners();
      });
    });
  }

  fetchData() {
    Tables.cAdds = [];
    Tables.cMain = [];
    Tables.cAuction = [];
    notifyListeners();
    FirebaseFirestore.instance
        .collection(classifiedAdshC)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tables.cAdds.add(doc["name"]);
        print(Tables.cAdds[0]);
      });
    });

    FirebaseFirestore.instance
        .collection(maintenancehC)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tables.cMain.add(doc["name"]);
        print(doc["name"]);
      });
    });

    FirebaseFirestore.instance
        .collection(aucationHC)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tables.cAuction.add(doc["name"]);
        print(doc["name"]);
      });
    });
//==============================
    FirebaseFirestore.instance
        .collection(classifiedAdsSC)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tables.cAddsSC.add(doc["name"]);
        print(Tables.cAddsSC[0]);
      });
    });

    FirebaseFirestore.instance
        .collection(maintenanceSC)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tables.cMainSC.add(doc["name"]);
        print(doc["name"]);
      });
    });

    FirebaseFirestore.instance
        .collection(aucationSC)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Tables.cAuctionSC.add(doc["name"]);
        print(doc["name"]);
      });
    });

    notifyListeners();
  }

  Future<void> sendNotificationCubit(
      {subject, title, stause, id, screen, sound}) async {
    print("trueeeeeestart");
    String toParams = "/topics/" + 'admin';

    final data = {
      "notification": {"body": subject, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": id,
        "status": stause,
        "name": sound,
        "screen": screen,
      },
      "to": "${toParams}"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=$keyFCM'
    };

    final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
// on success do
      print("trueeeeeeSened${response.body.toString()}");
      // emit(LiveSendNotificationSuccess());
    } else {
// on failure do

      print("falseeeeeeeeeeeeee");
      // emit(LiveSendNotificationError());
    }
  }

  deletingMyAdds({userId, name, context, tableName}) {
    showLoadingDialog(context, color: Colors.blue);
    notifyListeners();
    FirebaseFirestore.instance
        .collection("DataUsers")
        .doc(Common.userId)
        .collection("adds")
        .where("name", isEqualTo: name)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("DataUsers")
            .doc(Common.userId)
            .collection("adds")
            .doc(element.id)
            .delete()
            .then((value) {
          FirebaseFirestore.instance
              .collection(tableName)
              .where("name", isEqualTo: name)
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection(tableName)
                  .doc(element.id)
                  .delete()
                  .then((value) {
                pop(context);
                notifyListeners();
                print("Success!");
              });
            });
          }).onError((error, stackTrace) {
            print("errr1${error.toString()}");
            pop(context);
            notifyListeners();
          });

          // pop(context);
          // notifyListeners();
          // print("Success!");
        }).onError((error, stackTrace) {
          print("errrrrrrrrrr${error.toString()}");
          pop(context);
          notifyListeners();
        });
      });
    }).onError((error, stackTrace) {
      print("errrrrrrrrrr${error.toString()}");
      pop(context);
      notifyListeners();
    });
  }

  List<String> subCategories = [];
  List<String> subCategoriesServes = [];
  List<String> subCategoriesCars = [];
  List<String> subCategoriesOthers = [];
  List<String> subCategoriesJobs = [];

  List<Counter> counters = [];
  List<Counter> countersServes = [];
  List<Counter> countersCars = [];
  List<Counter> countersOthers = [];
  List<Counter> countersJobs = [];

  getSubCategoreisAdds() {
     subCategories = [];
     subCategoriesServes = [];
     subCategoriesCars = [];
     subCategoriesOthers = [];
     subCategoriesJobs = [];
    notifyListeners();
    FirebaseFirestore.instance
        .collection("ClassifiedAdsSC")
        .where("field", isEqualTo: "عقارات")
        .orderBy("time")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("errrrrrrrrrr${element["name"]}");
        subCategories.add(element["name"]);

        print(subCategories.length);
        notifyListeners();
      });
    });

    FirebaseFirestore.instance
        .collection("ClassifiedAdsSC")
        .where("field", isEqualTo: "خدمات")
        .orderBy("time")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("errrrrrrrrrr${element["name"]}");
        subCategoriesServes.add(element["name"]);
        print(subCategoriesServes.length);
        notifyListeners();
      });
    });
    FirebaseFirestore.instance
        .collection("ClassifiedAdsSC")
        .where("field", isEqualTo: "السيارات")
        .orderBy("time")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("errrrrrrrrrr${element["name"]}");
        subCategoriesCars.add(element["name"]);
        print(subCategoriesCars.length);
        notifyListeners();
      });
    });
    FirebaseFirestore.instance
        .collection("ClassifiedAdsSC")
        .where("field", isEqualTo: "منوعات")
        .orderBy("time")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("errrrrrrrrrr${element["name"]}");
        subCategoriesOthers.add(element["name"]);
        print(subCategoriesOthers.length);
        notifyListeners();
      });
    });
    FirebaseFirestore.instance
        .collection("ClassifiedAdsSC")
        .where("field", isEqualTo: "وظائف")
        .orderBy("time")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("errrrrrrrrrr${element["name"]}");
        subCategoriesJobs.add(element["name"]);
        print(subCategoriesJobs.length);
        notifyListeners();
      });
    });

    notifyListeners();
  }

  bool isLoadingCounter = false;

  Future getCounterAdds(List<String> categories) async {
    counters = [];

    notifyListeners();
    categories.forEach((element) {
      FirebaseFirestore.instance
          .collection("adds")
          .where("typeId", isEqualTo: element)
          .get()
          .then((value) {
        print("conunterrrrrr${value.docs.length}  + ${element} ");
        counters.add(Counter(value.docs.length, element));
      });
    });

    Future.delayed(const Duration(seconds: 1),() {
      notifyListeners();
    },);


 /*   subCategoriesServes.forEach((element) {
      FirebaseFirestore.instance
          .collection("adds")
          .where("typeId", isEqualTo: element)
          .get()
          .then((value) {
        print("conunterrrrrr${value.docs.length}  + ${element} ");
        countersServes.add(Counter(value.docs.length, element));
      });
    });
    subCategoriesCars.forEach((element) {
      FirebaseFirestore.instance
          .collection("adds")
          .where("typeId", isEqualTo: element)
          .get()
          .then((value) {
        print("conunterrrrrr${value.docs.length}  + ${element} ");
        countersCars.add(Counter(value.docs.length, element));
      });
    });
    subCategoriesOthers.forEach((element) {
      FirebaseFirestore.instance
          .collection("adds")
          .where("typeId", isEqualTo: element)
          .get()
          .then((value) {
        print("conunterrrrrr${value.docs.length}  + ${element} ");
        countersOthers.add(Counter(value.docs.length, element));
      });
    });
    subCategoriesJobs.forEach((element) {
      FirebaseFirestore.instance
          .collection("adds")
          .where("typeId", isEqualTo: element)
          .get()
          .then((value) {
        print("conunterrrrrr${value.docs.length}  + ${element} ");
        countersJobs.add(Counter(value.docs.length, element));
      });
    });*/



  }

  String getTextCount(name){
    notifyListeners();
 return   "${counters
        .firstWhere((element) =>
    element.name == name,orElse: () => Counter(0, "name"))
        .count}";

  }

  String counter = "";


}


class Counter {
  final int count;
  final String name;

  Counter(this.count, this.name);
}
