import 'package:flutter/material.dart';
import 'package:spotify_ui/model/homepagedatamodel.dart';
import 'package:spotify_ui/view/widgets/tools.dart';
import 'package:spotify_ui/viewmodel/apiConnections.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<HomePageDataModel> futureHomePageData;

  @override
  void initState() {
    super.initState();
    futureHomePageData = homeapiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 40,),
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
                            child: CircleAvatar(),
                          ),
                        );
                      })
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 44, 44, 44),
                          ),
                          child: const Center(
                            child: Text(
                              'Tümü',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 44, 44, 44),
                          ),
                          child: const Center(
                            child: Text(
                              'Müzik',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 44, 44, 44),
                          ),
                          child: const Center(
                            child: Text(
                              "Podcast'ler",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
                    
            const ContentOne(),
            const SizedBox(height: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kaldığın yerden devam et",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                ),
                const ContentTwo(),
              ],
            ),
            const SizedBox(height: 15,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      "Yakınlarda Çalınanlar",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    const ContentThree()
              ],
            ),
           
          ],
        ),
      ),
      drawer:  Drawers(),
      bottomNavigationBar:  BottomAppBars(),
    );
  }
}




class ContentOne extends StatefulWidget {
  const ContentOne({Key? key}) : super(key: key);

  @override
  State<ContentOne> createState() => _ContentOneState();
}

class _ContentOneState extends State<ContentOne> {
  late Future<HomePageDataModel> futureHomePageData;

  @override
  void initState() {
    super.initState();
    futureHomePageData = homeapiCall();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomePageDataModel>(
      future: futureHomePageData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Veri yok'));
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (snapshot.data!.items.length / 2).ceil(),
            itemBuilder: (context, index) {
              int startIndex = index * 2;
              int endIndex = startIndex + 2;
              if (endIndex > snapshot.data!.items.length) {
                endIndex = snapshot.data!.items.length;
              }

              return Row(
                children: [
                  for (int i = startIndex; i < endIndex; i++)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 44, 44),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                              child: Image.network(
                                snapshot.data!.items[i].image!,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                snapshot.data!.items[i].txt!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
class ContentTwo extends StatefulWidget {
  const ContentTwo({Key? key}) : super(key: key);

  @override
  State<ContentTwo> createState() => _ContentTwoState();
}

class _ContentTwoState extends State<ContentTwo> {
  late Future<HomePageDataModel> futureHomePageData;

  @override
  void initState() {
    super.initState();
    futureHomePageData = homeapiCall();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomePageDataModel>(
      future: futureHomePageData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Bir hata oluştu ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Veri yok'));
        } else {
          return SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.items.length,
              itemBuilder: (context, index) {
                if (index == 2 || index == 5 || index == 7) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 150,
                    child: Column(
                      children: [
                        Image.network(
                          snapshot.data!.items[index].image!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          snapshot.data!.items[index].txt!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Çalma Listesi",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        }
      },
    );
  }
}
class ContentThree extends StatefulWidget {
  const ContentThree({super.key});
  
  @override
  State<ContentThree> createState() => _ContentThreeState();
}

class _ContentThreeState extends State<ContentThree> {
  late Future<HomePageDataModel> futureHomePageData;
  
  

  @override
  void initState() {
    super.initState();
    futureHomePageData = homeapiCall();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomePageDataModel>(
      future: futureHomePageData,
      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError){
          return Center(child: Text("Bir hata oluştu ${snapshot.error}"),);
        }
        else if(!snapshot.hasData){
          return const Center(child: Text("Veri yok"));
        }
        else
        {
          return SizedBox(height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.items.length,
            itemBuilder:(context, index) {
              return Container(padding: EdgeInsets.symmetric(horizontal: 5),
                width: 100,
                child: Column(children: [
                  Image.network(snapshot.data!.items[index].image!,height: 100,
                                width: 100,
                                fit: BoxFit.cover,),
                                Expanded(
                              child: Text(
                                snapshot.data!.items[index].txt! ,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                ],),
              );
            }, ),);
        }
      },);
  }
}

