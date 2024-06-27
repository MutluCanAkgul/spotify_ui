import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify_ui/view/homeview.dart';
import 'package:spotify_ui/view/libraryview.dart';
import 'package:spotify_ui/view/searchview.dart';
import 'package:spotify_ui/view/userview/loginpage.dart';
import 'package:spotify_ui/view/userview/registerpage.dart';
import 'package:spotify_ui/viewmodel/validasyon.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBarTheme: const AppBarTheme(color: Colors.black,),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      transitionDuration:const Duration(milliseconds: 500),
      getPages: [
        GetPage(name: '/login', page:()=> const LoginPage(),
        transition: Transition.cupertino
        ),

        GetPage(name: '/register', page:()=>const RegisterPage(),
        transition: Transition.cupertino
        ),

        GetPage(name: '/home', page:()=>const Home()),
        GetPage(name: '/search', page:()=> const SearchView()),
        GetPage(name: '/library', page:()=> const LibraryView()),
      ],
      
    );
  }
}


