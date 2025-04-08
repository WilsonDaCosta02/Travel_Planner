import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 102, 141),
        title: Text(
          'Daftar Akun',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 34, 102, 141),
        child: Center(
          child: Dialog(
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
                        color: const Color.fromARGB(255, 34, 102, 141),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Image.asset('assets/images/Frame 1.png'),
                    ),

                    SizedBox(height: 40),

                    // === Nama Lengkap ===
                    buildInputField(Icons.person, 'Nama :', 'Nama lengkap'),

                    SizedBox(height: 10),

                    // === Nomor HP ===
                    buildInputField(
                      Icons.phone,
                      'HP :',
                      '08xxxxxxxxxx',
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 10),

                    // === Email ===
                    buildInputField(
                      Icons.email,
                      'Email :',
                      'example@gmail.com',
                    ),

                    SizedBox(height: 10),

                    // === Password ===
                    Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 206, 206, 206),
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
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 9,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
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

                    SizedBox(height: 20),

                    // === Tombol Register ===
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 99, 88, 220),
                        minimumSize: Size(300, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do you have account? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // kembali ke login
                          },
                          child: Text(
                            'Back to Login',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 114, 33, 243),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
    IconData icon,
    String label,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 206, 206, 206),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          Icon(icon),
          SizedBox(width: 15),
          Text(label),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              style: TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
