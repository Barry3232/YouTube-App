import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:flutter/material.dart';
import 'package:youtube_app/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isSignupLoading = false;

  Future<void> registerUser() async {
    final isValidate = _formKey.currentState?.validate();

    if (!isValidate!) {
      return;
    }
    _formKey.currentState?.save();

    setState(() {
      isSignupLoading = true;
    });


    try {
      final authInstance = f_auth.FirebaseAuth.instance;
      await authInstance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error occur')));
    } finally {
      setState(() {
        isSignupLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),

                const Center(
                  child: Text(
                    'REGISTRATION',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: firstNameController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'This is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.black),
                              // prefixIcon: const Icon(Icons.email),
                              hintText: 'David',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black45),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          controller: middleNameController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'This is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Middle Name',
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.black),
                              // prefixIcon: const Icon(Icons.email),
                              hintText: 'Lucky',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black45),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: lastNameController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'This is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.black),
                              // prefixIcon: const Icon(Icons.email),
                              hintText: 'ThankGod',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black45),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                floatingLabelStyle:
                                    const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(Icons.email),
                                hintText: 'User@gmail.com',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black45),
                                ))),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Password',
                                floatingLabelStyle:
                                    const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(Icons.password_outlined),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black45),
                                ))),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.white),
                                overlayColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.blueGrey),
                                side: MaterialStateProperty.resolveWith((states) =>
                                const BorderSide(color: Colors.black)),
                              ),
                              onPressed: registerUser,
                              child: isSignupLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : const Text('SignUp',
                                  style: TextStyle(color: Colors.black)),
                        ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
