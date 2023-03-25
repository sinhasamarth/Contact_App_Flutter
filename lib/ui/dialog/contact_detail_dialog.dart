import 'package:contact/controller/contact_database.dart';
import 'package:contact/controller/home_screen_controller.dart';
import 'package:contact/model/contact_model.dart';
import 'package:contact/ui/screens/contact_details_screen.dart';
import 'package:contact/ui/widgets/custom_circular_avatar.dart';
import 'package:contact/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailsDialog extends StatelessWidget {
  final ContactModel _data;

  final String _name;

  ContactDetailsDialog(this._data, {super.key}) : _name = _data.getFullName();

  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    var spacer = const SizedBox(
      height: 20,
    );
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          _buildTopBar(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CustomCircularAvatar(
              _data.image,
              40,
              _name.characters,
              theme:  Theme.of(context).textTheme.headlineMedium!,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              _name,
              style: Theme.of(context).textTheme.headlineMedium,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          spacer,
          _buildCallToActonMenu(context),
          Container(
            padding: const EdgeInsets.all(15),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        "Contact Information",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    _buildDetailTile(Icons.phone_outlined, _data.phoneNo),
                    _buildDetailTile(Icons.email_outlined, _data.email),
                    _buildDetailTile(
                        Icons.home_work_outlined, _data.companyName),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String data) {
    return data.isEmpty
        ? const SizedBox(
            height: 0,
            width: 0,
          )
        : ListTile(
            leading: Icon(icon),
            title: Text(
              _data.phoneNo,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          );
  }

  Container _buildCallToActonMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
        horizontal: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
      )),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              ExtensionsUtils.makeCall(_data.phoneNo);
            },
            icon: const Icon(Icons.phone_outlined),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => ContactDetailsScreen(_data));
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return alertDialog(context);
                  });
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }

  AlertDialog alertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Want To Delete This Contact'),
      content: Text(_name),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              ContactDatabase().delContact(_data.id!).then((value) {
                if (value == 1) {
                  ExtensionsUtils.showSnackBar(
                      context, "Deleted Contact $_name");
                  controller.fetchContact();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              });
            },
            child: const Text('Yes')),
        TextButton(
          onPressed: () {
            Navigator.pop(context); //close Dialog
          },
          child: const Text('Close'),
        )
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.25),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 4,
      ),
    );
  }
}
