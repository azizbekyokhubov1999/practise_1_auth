
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise_1_auth/components/my_button.dart';
import 'package:practise_1_auth/components/square_tile.dart';

import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
  //sign in method
  void signUserUp() async{
    //show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );
    //try sign in
    try{
      // check password confirmed or not
      if(passwordController.text == confirmPassword.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
      }
      else{
        errorMessage("Password doesn't match");
      }
      //back to home
      Navigator.pop(context);
    }on FirebaseAuthException catch (e){
      //back to home
      Navigator.pop(context);
      //showing error to user
      errorMessage(e.code);

    }
  }

  //error message
  void errorMessage(String message){
    showDialog(
        context: context,
        builder: (context){
          return   AlertDialog(
            title: Text(message,
              style: const TextStyle(
                  color: Colors.grey
              ),
            ),
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 25),
                //welcome back massage
                Text("Let's create an account for you",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                // username text field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // password text field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPassword,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                //sign in button
                MyButton(
                  text: "Sign up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 25),
                // or continue with other platform
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // google + apple sign in
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'images/img.png'),
                    SizedBox(width: 10),
                    SquareTile(imagePath: 'images/img_1.png')
                  ],
                ),
                const SizedBox(height: 25),
                // not a member  register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                      style: TextStyle(
                          color: Colors.grey[700]
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Login now",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        ),
                      ),
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
