import 'package:uasd/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailDiary extends StatelessWidget {
  final Diary diary;

  DetailDiary({required this.diary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 7, 112, 126),
        titleSpacing: 0,
        title: Text(
          DateFormat('dd/MM/yyyy').format(
            DateTime.fromMicrosecondsSinceEpoch(diary.date),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            diary.description,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
