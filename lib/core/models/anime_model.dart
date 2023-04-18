class Anime {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;

  Anime({
    this.id,
    this.title,
    this.slug,
    this.description,
  });

  static Anime fromMap({required Map map}) => Anime(
        id: map['id'],
        title: map['title'],
        slug: map['slug'],
        description: map['description'],
      );

  @override
  String toString() => 'Anime: id = $id, title = $title, slug = $slug';
}
