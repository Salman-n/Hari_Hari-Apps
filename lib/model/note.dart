class Note {
  String id;
  int date;
  String title;
  String description;

  Note({
    required this.date,
    required this.description,
    required this.id,
    required this.title,
  });

  factory Note.fromDatabase(String idNote, String title, String description, int date) => Note(
        date: date,
        description: description,
        id: idNote,
        title: title,
      );
}
