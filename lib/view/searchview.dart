import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify_ui/model/searchpagedatamodel.dart';
import 'package:spotify_ui/view/widgets/tools.dart';
import 'package:spotify_ui/viewmodel/apiConnections.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Builder(builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(),
                          child: CircleAvatar(),
                        ),
                      );
                    })
                  ],
                ),
                const SizedBox(width: 15),
                Text(
                  "Ara",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomSearchBar(
              onSearch: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Hepsine Göz At",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SearchContent1(searchQuery: searchQuery),
          ),
        ],
      ),
      drawer: Drawers(),
      bottomNavigationBar: BottomAppBars(),
    );
  }
}


class SearchContent1 extends StatefulWidget {
  final String searchQuery;
  const SearchContent1({super.key, required this.searchQuery});

  @override
  State<SearchContent1> createState() => _SearchContent1State();
}

class _SearchContent1State extends State<SearchContent1> {
  late Future<SearchPageLocalData> futureSearchPageData;

  @override
  void initState() {
    super.initState();
    futureSearchPageData = searchapiCall();
  }

  Color getCustomColors() {
    Random random = Random();
    return Color.fromARGB(random.nextInt(255), random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchPageLocalData>(
      future: futureSearchPageData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
          return const Center(child: Text('Veri yok'));
        } else {
          List<Item> filteredItems = snapshot.data!.items
              .where((item) =>
                  item.title!.toLowerCase().contains(widget.searchQuery.toLowerCase()))
              .toList();
          print('Filtered Items: $filteredItems'); // Debugging line

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 100 / 60,
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: getCustomColors(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        filteredItems[index].title!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
