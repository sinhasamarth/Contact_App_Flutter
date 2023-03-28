import 'package:contact/controller/contact_database.dart';
import 'package:contact/model/contact_model.dart';
import 'package:contact/utils/extensions.dart';
import 'package:flutter/material.dart';

class DelAlertDialog extends StatelessWidget {
  final String name;
  final int id;
  final Function onSuccessCallback ;

  const DelAlertDialog(
      {Key? key, required this.name, required this.id, required this.onSuccessCallback, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Want To Delete This Contact'),
      content: Text(name),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              ContactDatabase().delContact(id).then((value) {
                if (value == 1) {
                  ExtensionsUtils.showSnackBar(
                      context, "Deleted Contact $name");
                      onSuccessCallback();
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

}