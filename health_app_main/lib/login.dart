import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app_main/main.dart';
import 'package:provider/provider.dart';
import './firebaseAUTH/auth.dart'; // Import the Authentication class
import 'styles.dart'; // Import the styles

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.jpg', // Path to your image asset
              width: 100, // Adjust width as needed
              height: 100, // Adjust height as needed
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200], // Grey background for the page
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey, // Set key for the Form
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Enable auto validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/loginp.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Chào mừng trở lại!',
                          style: AppStyles.titleStyle,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Nhập email',
                        ),
                        validator: widget.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Nhập mật khẩu',
                        ),
                        validator: widget.validatePassword,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Add navigation logic for forgot password
                          },
                          style: AppStyles.textButtonStyle,
                          child: const Text('Quên mật khẩu?'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _signIn();
                          }
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: const Text('Đăng nhập'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Color(0xFF4C0F77),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("success");
      // Fetch the username and medication reminder times from Firestore
      String username = await _auth.fetchUsernameFromFirestore(user.uid);
      List<DateTime> medicationTimes =
          await _auth.fetchTimesDataFromFirestore(user.uid);
      // Cập nhật nhà cung cấp tên người dùng đã tìm nạp và thời gian nhắc nhở dùng thuốc
      Provider.of<UsernameProvider>(context, listen: false)
          .setUsername(username);

      // Schedule daily medication reminders

      Navigator.pushNamed(context, "/AndriodPrototype");
    } else {
      print("object is not found");
    }
  }
}
