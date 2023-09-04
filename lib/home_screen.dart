import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sponsorship_admin/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dataList = <QueryDocumentSnapshot<Map<String, dynamic>>>[];

  Future<void> getData() async {
    final data = await FirebaseFirestore.instance.collection('users').get();
    dataList = data.docs;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User details')),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ListView.builder(
            itemCount: dataList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  UserDetailsScreen(userId: dataList[index].id),
                      ));
                },
                child: Card(
                  // elevation: 0,
                  child: ListTile(
                    title: Text(dataList[index]['name']),
                    subtitle: Text(dataList[index]['email']),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          dataList[index]['photoURL']),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
