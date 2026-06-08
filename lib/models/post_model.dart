class Post {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String author;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int likes;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.author,
    required this.createdAt,
    this.updatedAt,
    this.likes = 0,
  });

  // Convertir depuis JSON (Firestore)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      authorId: json['authorId'] ?? '',
      author: json['author'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      likes: json['likes'] ?? 0,
    );
  }

  // Convertir en JSON (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'likes': likes,
    };
  }

  // Copier avec modifications
  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? authorId,
    String? author,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likes,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likes: likes ?? this.likes,
    );
  }
}
