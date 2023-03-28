import 'dart:developer';
import 'dart:ffi';

import 'package:contact/controller/contact_database.dart';
import 'package:contact/controller/home_screen_controller.dart';
import 'package:contact/ui/dialog/contact_detail_dialog.dart';
import 'package:contact/ui/screens/contact_details_screen.dart';
import 'package:contact/ui/widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact App",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(() {
                  var data = widget.controller.contactList;
                  var views = data
                      .map((e) => InkWell(
                            onTap: () {
                              Get.bottomSheet(ContactDetailsDialog(e));
                            },
                            child: ContactList(e),
                          ))
                      .toList();
                  return data.isEmpty
                      ? emptyState(context)
                      : Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: views,
                              ),
                            ),
                          ],
                        );
                }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => ContactDetailsScreen(null));
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyState(BuildContext context) => Center(
        child: Text(
          "No Contact Found",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      );
}

// Validation
// 6, 7, 8 ,9 // len 10
