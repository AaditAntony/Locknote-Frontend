class NoteModel {
  final int id;
  final String title;
  final String content;
  final bool deleted;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.deleted,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      deleted: json['deleted'],
    );
  }
}
