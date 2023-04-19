class Queries {
  final String queryAll = '''
  {
    animes {
      id
      title
      slug
      description
      thumbnail {
        id
        fileName
        url
      }
      epsodios {
        id
        title
        slug
        ep
      }
    }
  }
''';

  final queryAnimeById = '''
  query animeById(\$slug: String!) {
    anime(where: { slug: \$slug }) {
      id
      title
      description
      thumbnail {
        id
        fileName
        url
      }
      epsodios {
        title
        ep
        mp4 {
          id
          url
        }
      }
    }
  }
  ''';
}
