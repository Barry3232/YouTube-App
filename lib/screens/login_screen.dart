
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:flutter/material.dart';
import 'nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoginLoading = false;
  // bool isSignupLoading = false;

  Future<void> loginUser() async {
    final isValidate = _formKey.currentState?.validate();

    if (!isValidate!) {
      return;
    }
    _formKey.currentState?.save();

    setState(() {
      isLoginLoading = true;
    });

    try {
      final authInstance = f_auth.FirebaseAuth.instance;

      await authInstance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const NavBar();
      }));

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error occur')));


    } finally {
      setState(() {
        isLoginLoading = false;
      });


    }
  }

  // Future<void> registerUser() async {
  //   final isValidate = _formKey.currentState?.validate();
  //
  //   if (!isValidate!) {
  //     return;
  //   }
  //   _formKey.currentState?.save();
  //
  //   setState(() {
  //     isSignupLoading = true;
  //   });
  //
  //
  //   try {
  //     final authInstance = f_auth.FirebaseAuth.instance;
  //
  //     await authInstance.createUserWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim());
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Error occur')));
  //   } finally {
  //     setState(() {
  //       isSignupLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'this field is required';
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.white),
                                    overlayColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.blueGrey),
                                    side: MaterialStateProperty.resolveWith(
                                        (states) => const BorderSide(
                                            color: Colors.black)),
                                  ),
                                  onPressed: loginUser,
                                  child: isLoginLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const Text(
                                          'Login',
                                          style: TextStyle(color: Colors.black),
                                        )),
                            ),
                            // SizedBox(
                            //   width: 100,
                            //   child: ElevatedButton(
                            //     style: ButtonStyle(
                            //       backgroundColor:
                            //           MaterialStateProperty.resolveWith(
                            //               (states) => Colors.white),
                            //       overlayColor:
                            //           MaterialStateProperty.resolveWith(
                            //               (states) => Colors.blueGrey),
                            //       side: MaterialStateProperty.resolveWith(
                            //           (states) => const BorderSide(
                            //               color: Colors.black)),
                            //     ),
                            //     onPressed: registerUser,
                            //     child: isSignupLoading
                            //         ? const Center(
                            //             child: CircularProgressIndicator())
                            //         : const Text('SignUp',
                            //             style: TextStyle(color: Colors.black)),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Signup with ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'google?',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
