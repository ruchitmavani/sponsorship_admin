import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  _UserDetails(
                    text: 'Name',
                    userDetails: snapshot.data!['name'],
                  ),
                  _UserDetails(
                    text: 'Email',
                    userDetails: snapshot.data!['email'],
                  ),
                  if (snapshot.data!.data()!.containsKey('currentStatus'))
                    _UserDetails(
                      text: 'Current status',
                      userDetails: snapshot.data!['currentStatus'],
                    ),
                  if (snapshot.data!['lastActive'] != '')
                    _UserDetails(
                      text: 'Last Active',
                      userDetails: DateFormat('dd-MM-yyyy').format(
                          DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(snapshot.data!['lastActive']))),
                    ),
                  if (snapshot.data!['title'] != '')
                    _UserDetails(
                      text: 'Title',
                      userDetails: snapshot.data!['title'],
                    ),
                  if (snapshot.data!.data()!.containsKey('accountMainType'))
                    _UserDetails(
                      text: 'Account category',
                      userDetails: snapshot.data!['accountMainType'],
                    ),
                  if (snapshot.data!.data()!.containsKey('accountSubType'))
                    _UserDetails(
                      text: 'Account subcategory',
                      userDetails: snapshot.data!['accountSubType'],
                    ),
                  if (snapshot.data!.data()!.containsKey('interests') &&
                      (snapshot.data!['interests'] as List).isNotEmpty)
                    Row(
                      children: [
                        const Text(
                          'Interests : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...(snapshot.data!['interests'] as List).map(
                          (e) => Text(e),
                        )
                      ],
                    ),
                  if (snapshot.data!.data()!.containsKey('experties') &&
                      (snapshot.data!['experties'] as List).isNotEmpty)
                    Row(
                      children: [
                        const Text(
                          'Experties : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...(snapshot.data!['experties'] as List).map(
                          (e) => Text(e),
                        )
                      ],
                    ), if (snapshot.data!.data()!.containsKey('statusList') &&
                      (snapshot.data!['statusList'] as List).isNotEmpty)
                    Row(
                      children: [
                        const Text(
                          'StatusList : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...(snapshot.data!['statusList'] as List<Map>).map(
                          (e) => Text('data')),
                      ],
                    ),
                ],
              ),
            );
          }),
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    super.key,
    required this.text,
    required this.userDetails,
  });

  final String text;
  final String userDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$text : ',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(userDetails),
      ],
    );
  }
}
