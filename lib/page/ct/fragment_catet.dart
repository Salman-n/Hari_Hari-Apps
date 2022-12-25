import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/model/note.dart';
import 'package:uasd/page/ct/add_update_catet.dart';
import 'package:uasd/page/ct/detail_catet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/model/note.dart';
import 'package:uasd/page/ct/add_update_catet.dart';

class FragmCatet extends StatefulWidget {
  @override
  _FragmCatetState createState() => _FragmCatetState();
}

class _FragmCatetState extends State<FragmCatet> {
  void optionNote(Note note) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () => Get.back(result: 'detail'),
            title: Text('Detail'),
          ),
          ListTile(
            onTap: () => Get.back(result: 'update'),
            title: Text('Perbaharui'),
          ),
          ListTile(
            onTap: () => Get.back(result: 'delete'),
            title: Text('Hapus'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: Text('Tutup'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    switch (result) {
      case 'detail':
        Get.to(DetailNote(note: note));
        break;
      case 'update':
        Get.to(AddUpdateNote(note: note))?.then((value) => setState(() {}));
        break;
      case 'delete':
        EventRTDB.deleteNote(note);
        setState(() {});
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: EventRTDB.getListNote(),
          builder: (context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasData && snapshot.data!.length > 0) {
              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, thickness: 1),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Note note = snapshot.data![index];
                    DateTime date =
                        DateTime.fromMicrosecondsSinceEpoch(note.date);
                    return ListTile(
                      onTap: () => optionNote(note),
                      title: Text(
                        note.title,
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => setState(() {}),
                      icon: Icon(Icons.refresh)),
                  SizedBox(height: 16),
                  Text('Belum Ada Note (Catetan)'),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () =>
                Get.to(AddUpdateNote())?.then((value) => setState(() {})),
            backgroundColor: Asset.colorPrimer,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
