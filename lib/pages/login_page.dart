
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise_1_auth/components/my_button.dart';
import 'package:practise_1_auth/components/square_tile.dart';

import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
   const LoginPage({
     super.key,
     required this.onTap
   });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in method
   void signUserIn() async{
     //show loading circle
     showDialog(context: context, builder: (context) {
       return const Center(
         child: CircularProgressIndicator(),
       );
     },
     );
     //try sign in
     try{
     await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text
     );
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
                const SizedBox(height: 40),
                // logo
                 const Icon(
                   Icons.lock,
                   size: 100,
                 ),
                const SizedBox(height: 40),
                //welcome back massage
                Text("Welcome back you've been missed!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                ),
                const SizedBox(height: 20),
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
                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.grey[600]
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //sign in button
                MyButton(
                  text: 'Sign in',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 40),

                // google + apple sign in
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'images/img.png'),
                    SizedBox(width: 10),
                    SquareTile(imagePath: 'images/img_1.png')
                  ],
                ),
                const SizedBox(height: 35),
                // not a member  register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                      style: TextStyle(
                        color: Colors.grey[700]
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Register now",
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
