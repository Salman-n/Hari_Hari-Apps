import 'package:uasd/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uasd/model/note.dart';

class DetailNote extends StatelessWidget {
  final Note note;

  DetailNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 112, 126),
        titleSpacing: 0,
        title: Text(
          DateFormat('dd/MM/yyyy').format(
            DateTime.fromMicrosecondsSinceEpoch(note.date),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            note.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16),
          Text(
            note.description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
