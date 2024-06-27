import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_ui/view/widgets/tools.dart';
import 'package:spotify_ui/viewmodel/validasyon.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: SingleChildScrollView(
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
                    Text("Spotify'da Oturum Açın",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white, fontSize: 24))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
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
                            Expanded(
                              child: TextFormField(
                                validator: _controller.validateEmail,
                                style: const TextStyle(color: Colors.white),    
                                controller: _controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecorations.emailDecoration(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                           Expanded(
                              child: Obx(()=> TextFormField(
                                  validator: _controller.validatePassword,
                                  style: const TextStyle(color: Colors.white),
                                  controller: _controller.passwordController,          
                                  obscureText: _controller.passwordVisible.value,
                                  decoration: InputDecorations.passwordDecoration(
                                      _controller.passwordVisible.value,(){
                                        _controller.passwordVisible.toggle();
                                      })),)
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Parolayı Unuttum la',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Column(children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Beni Hatırla ",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white,fontSize: 15),),
                                    ],
                                  ),
                                 Obx(() =>  Switch(value:_controller.isSwitched.value
                                 , onChanged:(value){
                                    setState(() {
                                      _controller.isSwitched.value = value;
                                    });
                                  }),),
                                ],
                              ),
                            ],),
                           
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: customButton(text: "Giriş Yap", onTap:(){
                             _controller.login(context);
                            }, ),
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
                          "Spotify'da yeni misin? ",
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
                              Get.offAndToNamed('/register');
                            },
                            child: Text(
                              'Kayıt Ol',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 2,
                                      decorationColor: Colors.white),
                            ),
                          ),
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
