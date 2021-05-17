import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/auth.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_account.dart';
import 'package:foodz/services/dynamic_link.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets_default/confirm_button.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:foodz/widgets_default/section_title.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class GroceryListOption extends StatefulWidget {
  @override
  _GroceryListOption createState() => _GroceryListOption();
}

class _GroceryListOption extends State<GroceryListOption> {
  final GroceryListStates groceryListStates = Get.find();
  Future futureGroceryListAccounts;

  @override
  void initState() {
    futureGroceryListAccounts = groceryListStates.readAllGroceryListAccounts(groceryListStates.groceryList.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureGroceryListAccounts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            groceryListStates.groceryListAcounts.assignAll(snapshot.data);
            return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      _Members(
                          members: groceryListStates.groceryListAcounts,
                          groceryListUid: groceryListStates.groceryList.uid),
                    ],
                  ))),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: ConfirmButton(
                label: "confirm",
                enabled: !appStates.uploadingProfilePicture.value,
                onClick: () async {
                  groceryListStates.updateGroceryList();
                  Get.toNamed(URL_GROCERY_LIST,
                      arguments: groceryListStates.groceryList);
                },
              ),
            );
          } else
            return Container(color: Colors.white, child: FoodzLoading());
        });
  }
}

class _Members extends StatelessWidget {
  final List<EntityGroceryListAccount> members;
  final String groceryListUid;

  _Members({@required this.members, @required this.groceryListUid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SectionTitle(
                icon: Icons.accessibility_outlined,
                text: "WHO CAN ACCESS THIS LIST"),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () async {
                await Share.share(
                    'Hello! I would like to share with you my grocery list from Foodz : ' +
                        await dynamicLink
                            .createGroceryListInvitationLink(groceryListUid));
              },
              child: Icon(Icons.share),
            )
          ],
        ),
        Container(
          height: 10,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: members.length,
            itemBuilder: (BuildContext context, int i) {
              return Center(
                child: AutoSizeText(
                    members[i].uid == authService.auth.currentUser.uid
                        ? "You"
                        : members[i].uid),
              );
            })
      ],
    );
  }
}
