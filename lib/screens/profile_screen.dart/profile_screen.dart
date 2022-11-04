import 'package:biil_podu_app/constants/theme.dart';
import 'package:biil_podu_app/constants/theme_manager.dart';
import 'package:biil_podu_app/screens/profile_screen.dart/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:share_plus/share_plus.dart';
//import 'package:biil_podu_app/utils/functions.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

ThemeManager _themeManager = ThemeManager();

class _ProfilescreenState extends State<Profilescreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(() {});
    super.initState();
    notificationServices.initialseNotifications();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    String myEmail = FirebaseAuth.instance.app.name;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.toNamed("/login");
              },
              icon: const Icon(Icons.outbound_outlined),
            ),
            Switch(
                value: _themeManager.themeMode == ThemeMode.dark,
                onChanged: (newValue) {
                  setState(() {
                    _themeManager.toggleTheme(newValue);
                  });
                })
          ],
        ),
        bottomNavigationBar: GNav(
          gap: 5,
          tabs: [
            GButton(
              onPressed: () {
                Get.toNamed("/home");
              },
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              onPressed: () {
                Get.toNamed("/profile");
              },
              icon: Icons.person,
              text: 'profile',
            ),
            GButton(
              onPressed: () {
                Get.toNamed("/payment");
              },
              icon: Icons.monetization_on,
              text: 'payment',
            ),
          ],
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                notificationServices.sendNotification(
                    "Due Date", "Please pay the bill within in 15 days");
              },
              child: const Text(' Send Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                notificationServices.schedhuleNotification(
                    "ScheduledNofiction", "Please pay the bill within 14 days");
              },
              child: const Text(' Scheduled  Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                notificationServices.stopNotifications();
              },
              child: const Text(' Stop Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                sharePressed();
              },
              child: const Text("Share"),
            ),
            Center(
              child: FutureBuilder(
                future: _fetch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Text("Loading data...Please wait");
                  }
                  return Text("Email : $myEmail");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sharePressed({
    String path = "/storage/emulated/0/Documents",
  }) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    List<String>? files =
        result?.files.map((e) => e.path).cast<String>().toList();

    if (files == null) return;
    // ignore: deprecated_member_use
    await Share.shareFiles(files);
    // ignore: avoid_print
  }
}

class UserManagement {
  storeNewUser(user, context) async {
    // ignore: await_only_futures
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(firebaseUser.uid)
        .set({'email': user.email, 'uid': user.uid})
        .then((value) => Get.toNamed("/profile"))
        .catchError((e) {
          // ignore: avoid_print
          print(e);
        });
  }
}

_fetch() async {
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  // ignore: unnecessary_null_comparison
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      var myEmail = ds.data;
      // ignore: avoid_print
      print(myEmail);
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }
}
