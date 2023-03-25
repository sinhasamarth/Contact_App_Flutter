import 'dart:developer';

import 'package:contact/controller/contact_database.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final contactList = [].obs;

  HomeScreenController() {
    fetchContact();
  }

  void fetchContact() {
    ContactDatabase().fetchAllContacts().then((value) {
      contactList.value = value;
    });
  }
}
