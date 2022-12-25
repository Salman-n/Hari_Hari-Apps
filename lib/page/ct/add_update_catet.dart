import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/model/note.dart';
import 'package:flutter/material.dart';
import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/model/note.dart';

class AddUpdateNote extends StatefulWidget {
  final Note? note;
  const AddUpdateNote({this.note});

  @override
  _AddUpdateNoteState createState() => _AddUpdateNoteState();
}

class _AddUpdateNoteState extends State<AddUpdateNote> {
  var _controllerDescription = TextEditingController();
  var _controllerTitle = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.note != null) {
      _controllerDescription.text = widget.note!.description;
      _controllerTitle.text = widget.note!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 112, 126),
        titleSpacing: 0,
        title: Text(widget.note == null ? 'Menambahkan Note' : 'mengupdate Note'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _controllerTitle,
              cursorColor: Asset.colorPrimer,
              validator: (value) => value == '' ? "Tidak Boleh Kosong" : null,
              decoration: InputDecoration(
                hintText: 'Tuliskan Judul..',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Asset.colorPrimer, width: 2),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _controllerDescription,
              cursorColor: Asset.colorPrimer,
              maxLines: 15,
              minLines: 1,
              validator: (value) => value == '' ? "Tidak Boleh Kosong" : null,
              decoration: InputDecoration(
                hintText: 'Isi Teks Deskripsi...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Asset.colorPrimer, width: 2),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Asset.colorPrimer),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.note == null) {
                    EventRTDB.addNewNote(
                      DateTime.now().microsecondsSinceEpoch,
                      _controllerTitle.text,
                      _controllerDescription.text,
                    );
                  } else {
                    EventRTDB.updateNote(Note(
                      date: widget.note!.date,
                      description: _controllerDescription.text,
                      id: widget.note!.id,
                      title: _controllerTitle.text,
                    ));
                  }
                }
              },
              child: Text(widget.note == null ? 'Tambah' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
