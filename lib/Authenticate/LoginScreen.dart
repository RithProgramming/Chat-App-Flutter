import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Authenticate/CreateAccount.dart';
import 'package:flutter_application_1/Authenticate/Methods.dart';
import 'package:flutter_application_1/Screen/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

GlobalKey<FormState> _formKey = GlobalKey();

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
          body: isLoading
              ? Center(
                  child: Container(
                    height: size.height / 20,
                    width: size.height / 20,
                    child: const CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width / 0.5,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back_ios)),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Container(
                        width: size.width / 1.1,
                        child: const Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 1.1,
                        child: Text(
                          "Sign In to Contiue!",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 10,
                      ),
                      Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field(size, "email", Icons.account_box, _email),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Container(
                          width: size.width,
                          alignment: Alignment.center,
                          child: field(size, "password", Icons.lock, _password),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 10,
                      ),
                      customButton(size),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const CreateAccount())),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
            setState(() {
              isLoading = true;
            });

            logIn(_email.text, _password.text).then((user) {
              if (user != null) {
                print("Login Sucessfull");
                setState(() {
                  isLoading = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              } else {
                print("Login Failed");
                setState(() {
                  isLoading = false;
                });
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ការចូលគឺត្រឹមត្រូវ')));
          } else {
            print("Please fill form correctly");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('បញ្ចូលទិន្នន័យមិនទាន់គ្រប់លក្ខខណ៍'),
              duration: Duration(seconds: 3),
            ));
          }
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          // ignore: prefer_const_constructors
          child: Text(
            "Login",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextFormField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter Your Email and Password";
          }
          return null;
        },
      ),
    );
  }
}
