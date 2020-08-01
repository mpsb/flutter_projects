import 'package:flutter/material.dart';
import 'package:shopping_list/dbhelper.dart';
import 'package:shopping_list/models/shopping_list.dart';
import 'package:shopping_list/models/list_items.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopping List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Shopping List'),
          ),
          body: ShList(),
        ));
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();

  Future showData() async {
    await helper.openDb();
    ShoppingList list = ShoppingList(0, 'Bakery', 2);
    int listId = await helper.insertList(list);
    ListItem item = ListItem(0, listId, 'Bread', '1 kg', 'note');
    int itemId = await helper.insertItem(item);

    print('List ID: ' + listId.toString());
    print('Item ID: ' + itemId.toString());
  }

  @override
  Widget build(BuildContext context) {
    showData();

    return Container();
  }
}
