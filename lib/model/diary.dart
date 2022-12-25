class Diary{
  String id;
  int date;
  String description;

  Diary({
    required this.date,
    required this.description,
    required this.id,
  });

  factory Diary.fromDatabase(String idNote, String description, int date) => Diary(
        date: date,
        description: description,
        id: idNote,
      );
      
}