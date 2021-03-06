import 'package:flutter/material.dart';
import 'package:shopping_list/dbhelper.dart';
import 'package:shopping_list/models/list_items.dart';

class ListItemDialog {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildDialog(BuildContext context, ListItem item, bool isNew) {
    DbHelper helper = DbHelper();

    if (!isNew) {
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }

    return AlertDialog(
      title: Text((isNew) ? 'New List Item' : 'Edit List Item'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: 'Item Name',
              ),
            ),
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(
                hintText: 'Quantity',
              ),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                hintText: 'Note',
              ),
            ),
            RaisedButton(child: Text('Save List Item'),
                onPressed: () {
                  item.name = txtName.text;
                  item.quantity = txtQuantity.text;
                  item.note = txtNote.text;

                  helper.insertItem(item);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }

}