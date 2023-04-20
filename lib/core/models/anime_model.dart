class AnimeModel {
  String? sTypename;
  String? id;
  String? title;
  String? slug;
  String? description;
  Thumbnail? thumbnail;
  List<Epsodios>? epsodios;

  AnimeModel({
    this.sTypename,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.thumbnail,
    this.epsodios,
  });

  AnimeModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    if (json['epsodios'] != null) {
      epsodios = <Epsodios>[];
      json['epsodios'].forEach((v) {
        epsodios?.add(Epsodios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail?.toJson();
    }
    if (epsodios != null) {
      data['epsodios'] = epsodios?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() =>
      'id: $id, title: $title, slug: $slug, description: ${description?.substring(0, 50)}, thumbnail: $thumbnail, epsodios: $epsodios';
}

class Thumbnail {
  String? sTypename;
  String? id;
  String? fileName;
  String? url;

  Thumbnail({
    this.sTypename,
    this.id,
    this.fileName,
    this.url,
  });

  Thumbnail.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    fileName = json['fileName'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['id'] = id;
    data['fileName'] = fileName;
    data['url'] = url;
    return data;
  }

  @override
  String toString() => 'id: $id, filename: $fileName, url: $url';
}

class Epsodios {
  String? sTypename;
  String? title;
  int? ep;
  Mp4? mp4;

  Epsodios({
    this.sTypename,
    this.title,
    this.ep,
    this.mp4,
  });

  Epsodios.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    title = json['title'];
    ep = json['ep'];
    mp4 = json['mp4'] != null ? Mp4.fromJson(json['mp4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['title'] = title;
    data['ep'] = ep;
    if (mp4 != null) {
      data['mp4'] = mp4?.toJson();
    }
    return data;
  }

  @override
  String toString() => 'title: $title, ep: $ep';
}

class Mp4 {
  String? sTypename;
  String? id;
  String? url;

  Mp4({
    this.sTypename,
    this.id,
    this.url,
  });

  Mp4.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['id'] = id;
    data['url'] = url;
    return data;
  }

  @override
  String toString() => 'id: $id, url: $url';
}
