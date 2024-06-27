import 'package:flutter/material.dart';
import 'package:spotify_ui/model/librarypagedatamodel.dart';
import 'package:spotify_ui/view/widgets/tools.dart';
import 'package:spotify_ui/viewmodel/apiConnections.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  bool showXButton = false;
  String selectedType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Column(
                  children: [
                    Builder(builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(),
                        ),
                      );
                    })
                  ],
                ),
                const SizedBox(width: 15),
                Text(
                  "Kitaplığın",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Colors.white, size: 35),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white, size: 35),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 'Çalma Listeleri';
                      showXButton = false; // Hide X button when either button is selected
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedType == 'Çalma Listeleri'
                          ? Colors.green // Active button color
                          : const Color.fromARGB(255, 44, 44, 44),
                    ),
                    child: const Center(
                      child: Text(
                        'Çalma Listeleri',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 'Albüm';
                      showXButton = false; // Hide X button when either button is selected
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedType == 'Albüm'
                          ? Colors.green // Active button color
                          : const Color.fromARGB(255, 44, 44, 44),
                    ),
                    child: const Center(
                      child: Text(
                        'Albüm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (!showXButton && selectedType.isNotEmpty) // Conditionally show X button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = ''; // Clear selected type
                        showXButton = false; // Hide X button when tapped
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromARGB(255, 44, 44, 44),
                      ),
                      child: const Center(
                        child: Text(
                          'x',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            LibraryContent(selectedType: selectedType),
          ],
        ),
      ),
      drawer:  Drawers(),
      bottomNavigationBar: BottomAppBars(), 
    );
  }
}

class LibraryContent extends StatefulWidget {
  final String selectedType;

  const LibraryContent({Key? key, required this.selectedType}) : super(key: key);

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> {
  late Future<LibraryPageDataModel> futureLibraryPageData;

  @override
  void initState() {
    super.initState();
    futureLibraryPageData = libraryapiCall();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LibraryPageDataModel>(
      future: futureLibraryPageData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Hata : ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
          return const Center(child: Text("Veri yok"));
        } else {
          List<Item> filteredItems = snapshot.data!.items.where((item) {
            if (widget.selectedType == 'Çalma Listeleri') {
              return item.turu == 'Çalma Listesi';
            } else if (widget.selectedType == 'Albüm') {
              return item.turu == 'Albüm';
            }
            return true; // Show all items when selectedType is empty
          }).toList();

          return ListView.builder(
            shrinkWrap: true,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              Item item = filteredItems[index];
              return ListTile(
                leading: item.image != null
                    ? SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network(
                          item.image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(width: 50, height: 50),
                title: Text(
                  item.txt ?? 'No title',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.turu ?? 'No type'),
                    const SizedBox(width: 10),
                    Text(item.sanatci ?? 'No artist'),
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
