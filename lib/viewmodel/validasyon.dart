import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotify_ui/viewmodel/authServiceVM.dart';

class RegisterController extends GetxController{
  final AuthService _authService = AuthService();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  RxBool passwordVisible = true.obs;
 

  void togglePasswordVisibility(){
    passwordVisible.value = !passwordVisible.value;
  }
 

  String? validateName(String? value){
    if(value == null || value.isEmpty){
     return "Lütfen İsminizi Girin";
    }
    return null;
  }

   String? validateSurname(String? value){
    if(value == null || value.isEmpty){
     return "Lütfen Soyisminizi Girin";
    }
    return null;
  }

   String? validateEmail(String? value){
    if(value == null || value.isEmpty){
     return "Lütfen Email Adresinizi Girin";
    }
    if(!GetUtils.isEmail(value)){
      return "Lütfen Geçerli Bir Email Adresi Girin";
    }
    return null;
  }

  String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Lütfen Parola belirleyin";
    }
    if(value.length < 8){
      return "Parola boyutu en az 8 karakterli olmalı!";
    }
    return null;
  }

  Future<void> register(BuildContext context) async{
    if(!formKey.currentState!.validate()){
      return;
    }
   
    try{
      await _authService.insertUser({
        'name': nameController.text,
        'surname': surnameController.text,
        'email': emailController.text,
        'password': passwordController.text,}    
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text('Kayıt Başarılı'))),
      );
      Get.offAndToNamed('/login');
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('Kayıt Başarısız: $e'))),);
    }
    }
  }
class LoginController extends GetxController{
  
  
 final TextEditingController emailController = TextEditingController();
 final TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool passwordVisible = true.obs;
  RxBool isSwitched = false.obs;
  @override
  void onInit(){
    super.onInit();
      checkRememberMe();
    }
  
  void togglePasswordVisibility(){
    passwordVisible.value = !passwordVisible.value;
  }

   void checkRememberMe(){
    if(box.read('isRemembered') ?? false){
      emailController.text = box.read('email') ?? '';
      passwordController.text = box.read('password') ?? '';
      login(Get.context!);
    }
  }
  String? validateEmail(String? value){
    if(value == null || value.isEmpty){
     return "Lütfen Email Adresinizi Girin";
    }
    return null;
  }

  String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Lütfen Parolanızı girin";
    }  
    return null;
  }

  Future<void> login(BuildContext context) async{
    if(formKey.currentState?.validate() ?? false){
      String email = emailController.text;
      String password = passwordController.text;
  
      Map<String, dynamic>? user = await AuthService().loginUser(email, password);

      if(user != null){
       if(isSwitched.value){
        box.write('isRemembered', true);
        box.write('email', email);
        box.write('password', password);
       }
       else{
        box.remove('isRemembered');
        box.remove('email');
        box.remove('password');
       }
       Get.offAllNamed('/home');
      }
      else{
        Get.snackbar('Hata', 'E-Mail veya Parola hatalı',colorText: Colors.white);
      }
    }
  }
}

class UserController extends GetxController{
  RxString userName = ''.obs;

  void setUsername(String name){
    userName.value = name;
  }
}