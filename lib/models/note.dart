class Note {
  String id;
  String content;
  bool isSynced;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.content,
    this.isSynced = false, // Giá trị mặc định cho isSynced
    DateTime? updatedAt, // updatedAt có thể null trong constructor
  }) : updatedAt =
           updatedAt ?? DateTime.now(); // Gán updatedAt mặc định nếu null

  // Chuyển Note thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isSynced': isSynced ? 1 : 0, // Lưu bool dưới dạng int
      'updatedAt': updatedAt.toIso8601String(), // Lưu DateTime dưới dạng chuỗi
    };
  }

  // Tạo Note từ Map khi lấy từ SQLite
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      isSynced: map['isSynced'] == 1,
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  // Chuyển Note thành Map để lưu vào Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'content': content,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Tạo Note từ Firestore
  factory Note.fromFirestore(Map<String, dynamic> map, String id) {
    return Note(
      id: id,
      content:
          map['content'] ?? '', // Add default empty string if content is null
      isSynced: true, // Dữ liệu từ Firestore được coi là đã đồng bộ
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.parse(map['updatedAt'])
              : DateTime.now(), // Use current time if updatedAt is null
    );
  }
}
