import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Student.dart';

class StudentItem extends StatefulWidget {
  Student studentItem;
  StatelessWidget editScreen;

  StudentItem(this.studentItem, this.editScreen);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentItemState();
  }
}

class _StudentItemState extends State<StudentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.studentItem.name),
        subtitle: Text(widget.studentItem.subject),
        trailing: Padding(
          padding: EdgeInsets.only(right: 32),
          child: Text(widget.studentItem.point.toString()),
        ),
        leading: CircleAvatar(
          child: Text(widget.studentItem.subject.substring(0, 1)),
        ),
        onTap: () async {
          widget.studentItem = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget.editScreen));
          print('result = ${widget.studentItem.name}');
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              content: Text('Bạn thật sự muốn xóa chứ ?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Đừng'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Chốt'),
                  onPressed: () {
                    //REMOVE ITEM
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
