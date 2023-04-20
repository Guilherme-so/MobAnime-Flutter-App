import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobanime/core/models/anime_model.dart';
import 'package:mobanime/views/watch_anime_view.dart';
import 'package:mobanime/service/graphql_config.dart';
import 'constants/routes.dart';
import 'graphql/queries/graphql_queries.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Mob Anime',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(),
        routes: {
          animeRoute: (context) => const WatchAnimeView(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _queries = Queries();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text("MobAnime"),
        // backgroundColor: const Color.fromARGB(255, 86, 38, 170),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.connected_tv),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Query(
        options: QueryOptions(
            document: gql(_queries.queryAll),
            variables: const <String, dynamic>{"variableName": "value"}),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.data == null) {
            return const Center(
              child: Text("No animes found"),
            );
          }

          final animes = result.data!['animes'];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                child: ListTile(
                  leading: const Text(
                    'Trending Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'All',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  height: 210,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final title = animes[index]['title'];
                      final image = animes[index]['thumbnail']['url'];
                      final slug = animes[index]['slug'];

                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 150,
                        height: 200,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(animeRoute, arguments: slug);
                              },
                              child: ClipRRect(
                                child: Image.network(
                                  image,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: animes.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
