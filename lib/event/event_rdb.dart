import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:uasd/event/event_pref.dart';
import 'package:uasd/model/diary.dart';
import 'package:uasd/model/note.dart';

class EventRTDB {
  static void insertNewAccount(String uid, String email) async {
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid)
          .set({
            'email': email,
          })
          .then((value) => null)
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
    // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    // FirebaseDatabase database = FirebaseDatabase.instanceFor(app: secondaryApp);
  }

  static void addNewDiary(int date, String description) async {
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid!).child('diary')
          .push()
          .set({
            'date': date,
            'description': description,
          })
          .then((value) => Get.rawSnackbar(message: 'Menambah Diary Berhasil !', duration: const Duration(seconds: 1))
          ,)
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
    // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    // FirebaseDatabase database = FirebaseDatabase.instanceFor(app: secondaryApp);
  }

  static void updateDiary(Diary diary) async {
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid!)
          .child('diary')
          .child(diary.id)
          .update({
            'description': diary.description,
          })
          .then(
            (value) => Get.rawSnackbar(
              message: 'Memperbaharui Diary Berhasil !',
              duration: Duration(seconds: 1),
            ),
          )
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
  }

  static void deleteDiary(Diary diary) async {
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid!)
          .child('diary')
          .child(diary.id)
          .remove()
          .then(
            (value) => Get.rawSnackbar(
              message: 'Menghapus Diary Berhasil !',
              duration: Duration(seconds: 1),
            ),
          )
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
  }

  

  static Future<List<Diary>> getListDiary() async {
    List<Diary> listDiary = [];
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().ref(uid);
      final snapshot = await db.child("diary").get();

        final diarys = snapshot.children;
        
        for (final diary in diarys){
            String idNote = diary.key as String;
            String title = diary.child("title").value.toString();
            String description = diary.child("description").value.toString();
            String dateDB = diary.child("date").value.toString();
            listDiary.add(Diary.fromDatabase(idNote, description, int.tryParse(dateDB) as int));
            
      };
    } catch (e) {
      print(e);
    }
    return listDiary;
  }




  static void addNewNote(int date, String title, String description) async {
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid!)
          .child('note')
          .push()
          .set({
            'date': date,
            'title': title,
            'description': description,
          })
          .then(
            (value) => Get.rawSnackbar(
              message: 'Menambah Note Berhasil !',
              duration: Duration(seconds: 1),
            ),
          )
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
  }

  static void updateNote(Note note) async {
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid!)
          .child('note')
          .child(note.id)
          .update({
            'title': note.title,
            'description': note.description,
          })
          .then(
            (value) => Get.rawSnackbar(
              message: 'Memperbaharui Note Berhasil !',
              duration: Duration(seconds: 1),
            ),
          )
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
  }

  static void deleteNote(Note note) async {
    String? uid = await EventPref.getUid();
    try {
      final DatabaseReference db = FirebaseDatabase().reference();
      db
          .child(uid!)
          .child('note')
          .child(note.id)
          .remove()
          .then(
            (value) => Get.rawSnackbar(
              message: 'Menghapus Note Berhasil !',
              duration: Duration(seconds: 1),
            ),
          )
          .catchError((onError) => print(onError));
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Note>> getListNote() async {
    List<Note> listNote = [];
    String uid = await EventPref.getUid() as String;
    try {
      final DatabaseReference db = FirebaseDatabase().ref(uid);
      final snapshot = await db.child("note").get();

        final notes = snapshot.children;
        

        for (final note in notes){
            String idNote = note.key as String;
            String title = note.child("title").value.toString();
            String description = note.child("description").value.toString();
            String dateDB = note.child("date").value.toString();
            listNote.add(Note.fromDatabase(idNote, title, description, int.tryParse(dateDB) as int));
            
      };
    } catch (e) {
      print(e);
    }
    return listNote;
  }
}
