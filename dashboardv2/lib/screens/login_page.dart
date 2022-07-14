import 'package:admin/main.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/service/Api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/login_03.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 150, top: 150),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '', //''START FOR FREE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Ballighni .',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.grey[300]),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            '', // 'Already A Member?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              '', // 'Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /* Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.grey.withOpacity(.4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'First name',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.assignment_ind,
                                          color: Colors.grey[300],
                                        ),
                                        onPressed: () {},
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.grey[300]),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Card(
                              color: Colors.grey.withOpacity(.4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Last name',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.assignment_ind,
                                          color: Colors.grey[300],
                                        ),
                                        onPressed: () {},
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.grey[300]),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Card(
                          color: Colors.grey.withOpacity(.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextField(
                              onChanged: (value) => setState(() {
                                username = value;
                              }),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.grey[300],
                                    ),
                                    onPressed: () {},
                                  ),
                                  labelStyle:
                                      TextStyle(color: Colors.grey[300]),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.grey.withOpacity(.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            onChanged: (value) => setState(() {
                              password = value;
                            }),
                            style: const TextStyle(color: Colors.white),
                            obscureText: isVisible,
                            decoration: InputDecoration(
                                labelText: 'Mot de Passe ',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[300],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                ),
                                labelStyle: TextStyle(color: Colors.grey[300]),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          /* InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 170,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[600]!,
                                      Colors.grey[800]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  'Change method',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () async {
                              if (await Api().Auth2(username,
                                      password) //await Api().Auth2(username, password)
                                  ) {
                                runApp(MyApp());
                                /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                );*/
                              } else {
                                Fluttertoast.showToast(
                                    webPosition: "center",
                                    webShowClose: true,
                                    webBgColor:
                                        "linear-gradient(to right, #c42727,#c42727)",
                                    msg:
                                        "Erreur  nom d'utlisateur ou mot passe incorrect ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    //backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 170,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Colors.lightBlueAccent,
                                      Colors.blueAccent
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign-In ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Expanded(flex: 2, child: Card())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
