import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobanime/service/graphql_config.dart';
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
        home: const MyHomePage(title: "MobAnime"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Anime _anime = Anime();
  final _queries = Queries();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(widget.title),
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
            return Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final title = animes[index]['title'];
                  final image = animes[index]['thumbnail']['url'];

                  return Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
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
            );
          }),
    );
  }
}
