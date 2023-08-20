import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizzez/configs/configs.dart';
import 'package:quizzez/controllers/auth_controller.dart';
import 'package:quizzez/widgets/widgets.dart';
import 'package:quizzez/widgets/common/txt.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: kTabletChangePoint),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/app_splash_logo.svg',height: 100,),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'LEARN SOMETHING NEW TODAY!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),

              MyText(
                hintText:"Email",
                controller: controller.email.value,
              ),
              MyText(
                hintText:"Display name",
                controller: controller.username.value,
              ),
              MyText(
                hintText:"Password",
                controller: controller.password.value,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),

              MainButton(
                onTap: () {
                  controller.signInWithEmail();
                 },
                color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
