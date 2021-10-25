import 'package:flutter/material.dart';
import 'package:inamari/AllScreens/home_screen.dart';
import 'package:inamari/AllScreens/register_screen.dart';
import 'package:inamari/main.dart';
import 'package:inamari/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inamari/widgets/progress_dailog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String idScreen = "Login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 170.0,
              ),
              Center(
                child: logo(),
              ),
              SizedBox(
                height: 45.0,
              ),
              const Text(
                "Ku Gal Macmiil ahaan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontFamily: "Brand Bold"),
              ),
              SizedBox(
                height: 45.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 45.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email-ka aad gelisay sax maaha", context);
                        }
                        if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Password-ku waa khasab", context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                      child: Container(
                        height: 60,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RegistrationScreen.idScreen, (route) => false);
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 15.5,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgreeDialog("Fadlan Sug inta lagu xaqiijinayo...");
        });
    final User? firbaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((e) {
      Navigator.pop(context);
      displayToastMessage("Error: " + e.toString(), context);
    }))
        .user;

    if (firbaseUser != null) {
      //save user info to the databse

      usersRef.child(firbaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.idScreen, (route) => false);
          displayToastMessage("Xogtaadu waa sax, Mahadsanid", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("Xogta aad gelisay ma diwaangashana", context);
        }
      });
    } else {
      //error occured display mgs error
      Navigator.pop(context);
      displayToastMessage("Xogta aad gelisay waa khalad", context);
    }
  }
}
