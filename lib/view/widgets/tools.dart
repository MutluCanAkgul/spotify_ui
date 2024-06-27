// ignore_for_file: unnecessary_import, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sized_box_for_whitespace
 import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spotify_ui/viewmodel/validasyon.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        child: Image.asset(
          "images/spotifylogo.png",
          fit: BoxFit.cover,
        ));
  }
}

class InputDecorations {
  static InputDecoration emailDecoration() {
    return InputDecoration(
        hintText: 'E-Posta Adresiniz: ',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: const Icon(
          Icons.mail,
          color: Colors.white,
        ));
  }

  static InputDecoration passwordDecoration(
      bool passwordVisible, VoidCallback onPressed) {
    return InputDecoration(
        hintText: 'Parola: ',
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(
           passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ));
  }
}
Widget textFormField(
  {
    required hintText, 
    required TextEditingController controller,
    String? Function(String?)? validator,
    int? expanded
}
)
{
  if(expanded != null)
  {
   return Expanded(child: 
   TextFormField(
    controller: controller,
    keyboardType: TextInputType.name,
    style:const TextStyle(color: Colors.white),
    decoration: InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      
    ),validator:validator,
   ),
   );
  }
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.name,
    style:const TextStyle(color: Colors.white),
    decoration: InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),validator: validator,
  );
}

Widget customButton(
  {
    required String text,
    required VoidCallback onTap,
    int? expanded,
    }
    ){
     if(expanded != null){
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(height: 60,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
           child: Center(
             child: Text(text, style:const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600),
                       ),
           ),
         ),
        ),
      );
     }
     return GestureDetector(
          onTap: onTap,
          child: Container(height: 60,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
           child: Center(
             child: Text(text, style:const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600),
                       ),
           ),
         ),
        );
    }
    
class BottomAppBars extends StatelessWidget{
  final _controller = Get.put(NavigationController());
  
  @override
  Widget build(BuildContext context) {
    return Obx(() =>  BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      currentIndex: _controller.selectedIndex.value,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: (index)=> _controller.changeIndex(index),
      items: [
        const BottomNavigationBarItem(icon:Icon(Icons.home,size: 30,),label: 'Ana sayfa',),
        const BottomNavigationBarItem(icon:Icon(Icons.search,size: 30,),label: 'Ara'),
        const BottomNavigationBarItem(icon:Icon(Icons.my_library_music,size: 30,),label: 'Kitaplığın'),
      ],
    ));
  }
   
}
class NavigationController extends GetxController{
  final RxInt selectedIndex = 0.obs;
  
  void changeIndex(int index){
    selectedIndex.value = index;
    switch(index){
      case 0:
      Get.toNamed('/home');
      break;
      case 1:
      Get.toNamed('/search');
      break;
      case 2:
      Get.toNamed('/library');
      break;
    }
  }
}


class Drawers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      child: ListView(
        children: [
          ListTile(
            onTap: () {
            
            },
            leading: const CircleAvatar(),
            title: Obx(() => Text(
                  userController.userName.value, 
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                )),
            subtitle: Text(
              'Profili görüntüle',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          SizedBox(
            child: Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.white),
            title: Text(
              'Hesap Ekle',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.flash_on, color: Colors.white),
            title: Text(
              'Yenilikler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.av_timer, color: Colors.white),
            title: Text(
              'Dinleme Geçmişi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          ListTile(
            onTap: () {
              // Ayarlar sayfasına git
            },
            leading: const Icon(Icons.settings, color: Colors.white),
            title: Text(
              'Ayarlar ve Gizlilik',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/login');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Oturumu Kapat',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Ne dinlemek istiyorsun?',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color.fromARGB(255, 44, 44, 44),
                      ),
                  border: InputBorder.none,
                ),
                onChanged: widget.onSearch,
              ),
            ),
            IconButton(
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
      ),
    );
  }
}