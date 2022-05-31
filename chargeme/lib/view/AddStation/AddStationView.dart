import 'package:chargeme/view/AddStation/ChangeStationNameView/ChangeStationNameView.dart';
import 'package:flutter/material.dart';

class AddStationView extends StatelessWidget {
  AddStationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text("Name"),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeStationNameView(),
                ),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text("Description"),
          ),
        )
      ],
    );
  }
}
