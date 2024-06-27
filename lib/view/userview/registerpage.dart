import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_ui/view/widgets/tools.dart';
import 'package:spotify_ui/viewmodel/validasyon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
    @override
  State<RegisterPage> createState()=> _RegisterPage();
}
  final RegisterController _controller = Get.put(RegisterController());

 class _RegisterPage extends State<RegisterPage>{
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Logo()],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Spotify'a Katıl",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 22, 22, 22),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Column(
                      children: [
                        Row(
                          children: [
                           Expanded(child: textFormField(validator: _controller.validateName,hintText: 'İsminiz: ', controller: _controller.nameController))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                           Expanded(child: textFormField(validator:_controller.validateSurname, hintText: 'Soyisminiz: ', controller: _controller.surnameController))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(children: [
                          Expanded(child: TextFormField(validator: _controller.validateEmail,
                            style: const TextStyle(color: Colors.white),
                            controller: _controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecorations.emailDecoration(),
                          ),
                          ),
                        ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                         Obx(() =>  Expanded(child: TextFormField(
                            validator: _controller.validatePassword,
                            controller: _controller.passwordController,
                            obscureText: _controller.passwordVisible.value,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecorations.passwordDecoration(_controller.passwordVisible.value,(){_controller.passwordVisible.toggle();}),                         
                          ),
                          ),)
                        ]
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: customButton(text: 'Kayıt Ol', onTap:()=> _controller.register(context),
                              )
                            )
                          ],
                        )
                        
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Hesabınız mı var? ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.offAndToNamed('/login');
                            },
                            child: Text(
                              'Giriş Yap',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 2,
                                      decorationColor: Colors.white),
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
 }
