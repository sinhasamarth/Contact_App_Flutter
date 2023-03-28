import 'package:contact/controller/contact_details_controller.dart';
import 'package:contact/model/contact_model.dart';
import 'package:contact/ui/dialog/del_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailsScreen extends StatefulWidget {
  final ContactModel? data;
  bool isEdit;

  ContactDetailsScreen(this.data, {super.key, required})
      : isEdit = data != null ? true : false;

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  late BuildContext context;

  // Controllers

  late ContactDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ContactDetailsController(widget.data));
  }

  // Name Controllers
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _middleNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  // Other Details Controller
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var body = Scaffold(
      appBar: _buildAppBar(),
      body: _body(context),
    );
    setData();
    return body;
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(widget.isEdit ? "Edit Contact" : "Create New Contact"),
      actions: [
        ElevatedButton(
            onPressed: () {
              addToDataBase(context);
            },
            child: const Text("Save")),
        widget.isEdit
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) =>
                      DelAlertDialog(
                        id: widget.data?.id ?? -1,
                        name: widget.data?.firstName ?? " ",
                        onSuccessCallback: () {
                          controller.delContact(context);
                          if(widget.isEdit) {
                            Navigator.pop(context);
                          }
                        },
                      )
                      );
                    },
                    icon: const Icon(Icons.delete_outline)))
            : const SizedBox(
                width: 10,
              ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          InkWell(onTap: () {
            controller.getImage();
          }, child: Obx(() {
            return CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              radius: 50,
              backgroundImage: controller.isImageFetched.isTrue
                  ? MemoryImage(controller.imageData.value)
                  : null,
              child: const Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.white,
              ),
            );
          })),
          Obx(
            () => controller.isImageFetched.isFalse
                ? Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      "Add a picture",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
          ),
          getTextTile("First Name", TextInputType.text, _firstNameController,
              Icons.person_outline),
          getTextTile(
              "Middle Name", TextInputType.text, _middleNameController, null),
          getTextTile(
              "Last Name", TextInputType.text, _lastNameController, null),
          getTextTile("Phone", TextInputType.phone, _phoneController,
              Icons.phone_outlined),
          getTextTile("Email", TextInputType.emailAddress, _emailController,
              Icons.email_outlined),
          getTextTile("Company", TextInputType.text, _companyController,
              Icons.home_work_outlined)
        ],
      ),
    );
  }

  ListTile getTextTile(String labelText, TextInputType inputType,
      TextEditingController controller, IconData? icon) {
    controller.text = "";
    return ListTile(
        leading: icon != null ? Icon(icon) : const SizedBox(),
        iconColor: Theme.of(context).primaryColor,
        title: TextField(
          keyboardType: inputType,
          controller: controller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
        ));
  }

  addToDataBase(BuildContext context) {
    controller.addToDatabase(
        firstName: _firstNameController.text.trim(),
        middleName: _middleNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNo: _phoneController.text.trim(),
        emailId: _emailController.text.trim(),
        companyName: _companyController.text.trim(),
        context: context);
  }

  void setData() {
    if (widget.data != null) {
      var data = widget.data!;
      _firstNameController.text = data.firstName;
      _middleNameController.text = data.middleName;
      _lastNameController.text = data.lastName;
      _phoneController.text = data.phoneNo;
      _emailController.text = data.email;
      _companyController.text = data.companyName;
    }
  }
}
