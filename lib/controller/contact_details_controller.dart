import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:contact/controller/contact_database.dart';
import 'package:contact/controller/home_screen_controller.dart';
import 'package:contact/model/contact_model.dart';
import 'package:contact/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContactDetailsController extends GetxController {
  final ContactModel? _contactDetails;
  final isImageFetched = false.obs;
  final imageData = Uint8List(0).obs;

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  ContactDetailsController(this._contactDetails) {
    if (_contactDetails != null) {
      isImageFetched.value = true;
      try {
        imageData.value = base64Decode(_contactDetails!.image);
      } catch (_) {}
    }
  }

  getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      isImageFetched.value = true;
      imageData.value = await File(image.path).readAsBytes();
    } else {
      isImageFetched.value = false;
    }
  }

  addToDatabase({
    required String firstName,
    required String middleName,
    required String lastName,
    required String phoneNo,
    required String emailId,
    required String companyName,
    required BuildContext context,
  }) {
    var encodedImage =
        isImageFetched.isTrue ? base64Encode(imageData.value) : '';
    log(encodedImage);
    var data = ContactModel(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNo: phoneNo,
        email: emailId,
        companyName: companyName,
        birthDay: ' '.trim(),
        image: encodedImage);
    log(data.toString());

    if (data.phoneNo.isEmpty) {
      ExtensionsUtils.showSnackBar(context, "Phone Number Can't be empty");
    } else {
      if (data.getFullName().isEmpty) {
        data.firstName = data.phoneNo;
      }

      if (_contactDetails != null) {
        int id = _contactDetails!.id ?? -1;
        ContactDatabase().updateContact(id, data).then((value) {
          if (value == 0) {
            ExtensionsUtils.showSnackBar(
                context, "Some Error Occurred Please Try Again");
          } else {
            ExtensionsUtils.showSnackBar(
                context, "Contact Updated Successfully");
            homeScreenController.fetchContact();
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
      } else {
        ContactDatabase().insertContacts(data).then((value) {
          if (value == 0) {
            ExtensionsUtils.showSnackBar(
                context, "Some Error Occurred Please Try Again");
          } else {
            ExtensionsUtils.showSnackBar(
                context, "New Contact Added ${data.getFullName()}");
            homeScreenController.fetchContact();
            Navigator.pop(context);
          }
        });
      }
    }
  }

  void delContact(BuildContext context) {
    if (_contactDetails != null) {
      ContactDatabase().delContact(_contactDetails!.id!).then((value) {
        if (value == 1) {
          ExtensionsUtils.showSnackBar(
              context, "Deleted Contact ${_contactDetails?.getFullName()}");

          homeScreenController.fetchContact();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    }
  }
}
