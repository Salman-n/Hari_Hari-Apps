import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/model/diary.dart';
import 'package:uasd/page/dy/add_update_diary.dart';
import 'package:uasd/page/dy/detail_diary.dart';

class FragmDiary extends StatefulWidget {
  @override
  _FragmDiaryState createState() => _FragmDiaryState();
}

class _FragmDiaryState extends State<FragmDiary> {
  void optionDiary(Diary diary) async {
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
        Get.to(DetailDiary(diary: diary));
        break;
      case 'update':
        Get.to(AddUpDiary(diary: diary))?.then((value) => setState(() {}));
        break;
      case 'delete':
        EventRTDB.deleteDiary(diary);
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
          future: EventRTDB.getListDiary(),
          builder: (context, AsyncSnapshot<List<Diary>> snapshot) {
            if (snapshot.hasData && snapshot.data!.length > 0) {
              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, thickness: 1),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Diary diary = snapshot.data![index];
                    DateTime date =
                        DateTime.fromMicrosecondsSinceEpoch(diary.date);
                    return ListTile(
                      onTap: () => optionDiary(diary),
                      title: Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        diary.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
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
                  Text('Belum Ada Diary (Kegiatan)'),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Get.to(AddUpDiary())?.then((value) => setState(() {}));
            },
            backgroundColor: Asset.colorPrimer,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
