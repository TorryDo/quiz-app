class Topic {

  int id;
  String title;
  String description;

  Topic({
    required this.id,
    required this.title,
    this.description = '',
  });
}

