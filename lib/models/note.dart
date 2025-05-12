class Note {
  String id;
  String content;

  Note({required this.id, required this.content});

  // Chuyển Note thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content};
  }

  // Tạo Note từ Map khi lấy từ SQLite
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], content: map['content']);
  }
}
