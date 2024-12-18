import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'login.dart'; // Import the login page
import 'signup.dart'; // Import the signup page
import 'HomePage.dart';
import 'medication.dart';
import 'appointments.dart';
import 'Fitness_Page.dart';
import 'nurtition_screen.dart';
import 'fitness.dart';

import 'water_remainder.dart';

import 'package:health_app_main/sleep.dart';

import 'firebaseAUTH/auth.dart'; // Import auth service

class UsernameProvider extends ChangeNotifier {
  String _username = '';

  String get username => _username;

  void setUsername(String username) {
    _username = username;
    notifyListeners(); // Notify listeners that the username has changed
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final AuthService _authService = AuthService();
//firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notifications
  final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'));

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground message received: ${message.notification?.title}");
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text('New Message'),
          content: Text(message.notification?.title ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  });

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (context) => UsernameProvider(),
      child: MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message received: ${message.notification?.title}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Health App',
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/AndriodPrototype': (context) => const AndriodPrototype(),
        '/appointment': (context) => AppointmentsPage(),
        '/medication': (context) => MedicationAlarmScreen(),
        '/FitnessPage': (context) => FitnessPage(),
        '/sleep': (context) => SleepPage(
              authService: _authService,
            ),
        '/fitness': (context) => FitnessScreen(),
        '/water': (context) => WaterReminder(),
        '/nutrition': (context) => RecipeScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 280,
            child: Image.asset(
              'assets/starting.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.99,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 76, 15, 119),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sức khỏe điện tử',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Hãy bắt đầu cuộc hành trình của bạn.",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double
                          .infinity, // Set width to match parent container
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF4C0F77),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Color(0xFF4C0F77)),
                          ),
                        ),
                        child: const Text(
                          'Đăng Nhập',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double
                          .infinity, // Set width to match parent container
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF4C0F77),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Đăng Ký',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
