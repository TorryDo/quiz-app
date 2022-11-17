class Topic {
  int id;
  String title;
  String description;

  Topic({
    required this.id,
    required this.title,
    this.description = '',
  });

  Topic copyWith({int? id, String? title, String? description}) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
