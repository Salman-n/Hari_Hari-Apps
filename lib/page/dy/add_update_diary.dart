import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:uasd/config/asset.dart';
import 'package:uasd/event/event_rdb.dart';
import 'package:uasd/model/diary.dart';

class AddUpDiary extends StatefulWidget {

final Diary? diary;
const AddUpDiary({super.key, this.diary});

  @override
  State<AddUpDiary> createState() => _AddUpDiaryState();
}

class _AddUpDiaryState extends State<AddUpDiary> {
  var _controllerDescription = TextEditingController();
  @override
  void initState() {
    if (widget.diary != null) {
      _controllerDescription.text = widget.diary!.description;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0,
      backgroundColor: Color.fromARGB(255, 7, 112, 126),
      title: Text(widget.diary==null?'Menambahkan Diary':'Mengupdate Diary'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
        TextField(
          controller: _controllerDescription ,
          cursorColor: Asset.colorPrimer,
          maxLines: 15,
          minLines: 1,
          decoration: InputDecoration(
            hintText: 'Isi Deskripsi disini...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Asset.colorPrimer, width: 2),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) => Asset.colorPrimer)
          ),
          onPressed: (){
                if (_controllerDescription.text != '') {
                if (widget.diary == null) {
                  EventRTDB.addNewDiary(
                    DateTime.now().microsecondsSinceEpoch,
                    _controllerDescription.text,
                  );
                } else {
                  EventRTDB.updateDiary(Diary(
                    date: widget.diary!.date,
                    description: _controllerDescription.text,
                    id: widget.diary!.id,
                  ));
                }
              }
          }, 
          child: Text(widget.diary==null?'Tambah':'Update')),
      ],),
    );
  }
}