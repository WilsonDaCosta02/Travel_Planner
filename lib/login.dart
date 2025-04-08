import 'package:flutter/material.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 34, 102, 141),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Logo.png'),
              SizedBox(height: 15),

              SizedBox(
                width: 235,
                child: Text(
                  textAlign: TextAlign.center,
                  'Plan your tour travel and forget your burden, we will remind you in advance!',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Image.asset('assets/images/image 1.png'),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 193, 203, 156),
                  minimumSize: Size(300, 46),
                ),
                child: Text(
                  'Get Started !',
                  style: TextStyle(
                    color: Color.fromARGB(255, 34, 102, 141),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setStateDialog) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                width: 500,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          34,
                                          102,
                                          141,
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Image.asset(
                                        'assets/images/Frame 1.png',
                                      ),
                                    ),

                                    SizedBox(height: 40),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(300, 33),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/google.png',
                                            width: 17,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Login With Google',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(300, 33),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/facebook.png',
                                            width: 17,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Login With Facebook',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Divider(),

                                    Container(
                                      width: double.infinity,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          206,
                                          206,
                                          206,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Icon(Icons.email),

                                          SizedBox(width: 15),
                                          Text('Email :'),

                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'example@gmail.com',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 9,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          206,
                                          206,
                                          206,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Icon(Icons.key),

                                          SizedBox(width: 15),
                                          Text('Password :'),

                                          Expanded(
                                            child: TextField(
                                              obscureText: _obscureText,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'Masukkan Password',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 9,
                                                    ),

                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setStateDialog(() {
                                                      _obscureText =
                                                          !_obscureText;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    _obscureText
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                114,
                                                33,
                                                243,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.grey,
                                        checkboxTheme: CheckboxThemeData(
                                          shape: CircleBorder(),
                                          visualDensity: VisualDensity(
                                            horizontal: -4.0,
                                            vertical: -4.0,
                                          ),
                                        ),
                                      ),
                                      child: CheckboxListTile(
                                        title: Text(
                                          'Remember Me',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ), // kecilin font kalau perlu
                                        ),
                                        value: _rememberMe,
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            _rememberMe = value!;
                                          });
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        contentPadding: EdgeInsets.zero,
                                        dense:
                                            true, // ini juga bantu biar lebih padat
                                        visualDensity: VisualDensity(
                                          horizontal: -4.0,
                                          vertical: -4.0,
                                        ),
                                      ),
                                    ),

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          99,
                                          88,
                                          220,
                                        ),
                                        minimumSize: Size(300, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(' Don`t have an account? '),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const Register(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Register Account',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                114,
                                                33,
                                                243,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
