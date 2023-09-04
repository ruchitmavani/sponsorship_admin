import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sponsorship_admin/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB4foUVYlIg1JpV9zCq2WHM89tFSpHHy_Q",
        authDomain: "sponsershipp-8f2be.firebaseapp.com",
        projectId: "sponsershipp-8f2be",
        storageBucket: "sponsershipp-8f2be.appspot.com",
        messagingSenderId: "145794282100",
        appId: "1:145794282100:web:3a03e4ddcf02c493ae5721",
        measurementId: "G-JQD6SP0FXR"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
