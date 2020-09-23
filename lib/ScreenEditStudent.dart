import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Student.dart';

class ScreenEditStudent extends StatelessWidget {
  Student student;

  ScreenEditStudent(this.student);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Editor")),
      body: Container(
        child: Column(
          children: [
            new TextFormField(
              onChanged: (String value) {
                student.name = value;
              },
              initialValue: student.name,
              decoration: InputDecoration(
                hintText: 'Enter name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            SizedBox(height: 16),
            new TextFormField(
              onChanged: (String value) {
                student.subject = value;
              },
              initialValue: student.subject,
              decoration: InputDecoration(
                hintText: 'Enter subject',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            SizedBox(height: 16),
            new TextFormField(
              onChanged: (String value) {
                student.point = double.parse(value);
              },
              initialValue: student.point.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter point',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            FlatButton(
              child: Text('Update'),
              onPressed: () {
                if (student.name != null &&
                    student.point != null &&
                    student.subject != null) {
                  Navigator.of(context).pop(student);
                }
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
