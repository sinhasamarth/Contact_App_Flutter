import 'dart:convert';

import 'package:contact/model/contact_model.dart';
import 'package:contact/ui/widgets/custom_circular_avatar.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final ContactModel _contactModel;
  final String _fullName;

  ContactList(this._contactModel, {super.key})
      : _fullName = _contactModel.getFullName();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CustomCircularAvatar(
            _contactModel.image,
            20,
            _fullName.characters,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              _fullName,
              style: const TextStyle(fontSize: 15),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
