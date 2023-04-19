import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/queries/graphql_queries.dart';

class WatchAnimeView extends StatefulWidget {
  const WatchAnimeView({super.key});

  @override
  State<WatchAnimeView> createState() => _WatchAnimeViewState();
}

class _WatchAnimeViewState extends State<WatchAnimeView> {
  final _queries = Queries();
  String _args = '';
  bool toogleDescription = true;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    _args = args.toString();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
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
      body: SingleChildScrollView(
        child: Query(
          options: QueryOptions(
            document: gql(_queries.queryAnimeById),
            variables: <String, dynamic>{
              "slug": _args,
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.data == null) {
              return const Center(
                child: Text("No anime found!"),
              );
            }

            final anime = result.data!['anime'];
            final image = anime!['thumbnail']['url'];
            final title = anime['title'];
            final episodesNumber = anime['epsodios'].length;
            final description = anime['description'];
            print(description);

            return Column(
              children: [
                ClipRRect(
                  child: Image.network(
                    image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'English - $episodesNumber Episodes',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      description,
                      maxLines: toogleDescription ? 6 : 100,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 20, 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          toogleDescription = !toogleDescription;
                        });
                      },
                      child: Text(
                        toogleDescription ? 'Show More' : 'Show Less',
                        style: TextStyle(
                          color: Colors.lightBlue.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 20, 0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: ListTile(
                        leading: Icon(
                          Icons.ac_unit,
                          color: Colors.white,
                        ),
                        title: Text(
                          'EP1',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
