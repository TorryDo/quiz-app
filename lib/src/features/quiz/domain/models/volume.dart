class Volume {
  int id;
  int topicId;
  String title;

  Volume({
    required this.id,
    required this.topicId,
    required this.title,
  });

  Volume copyWith({int? id, int? topicId, String? title}) {
    return Volume(
        id: id ?? this.id,
        topicId: topicId ?? this.topicId,
        title: title ?? this.title);
  }
}
