import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LabTechnicianTopbar
    extends StatefulWidget {

  const LabTechnicianTopbar({
    super.key,
  });

  @override
  State<LabTechnicianTopbar> createState() => _LabTechnicianTopbarState();
}

class _LabTechnicianTopbarState extends State<LabTechnicianTopbar> {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      notificationSubscription;
  final Set<String> shownNotificationIds = {};

  @override
  void initState() {
    super.initState();
    _listenForAlertResponsePopups();
  }

  @override
  void dispose() {
    notificationSubscription?.cancel();
    super.dispose();
  }

  void _listenForAlertResponsePopups() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return;
    }

    notificationSubscription = FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: uid)
        .where('type', isEqualTo: 'alertResponse')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      for (final change in snapshot.docChanges) {
        final doc = change.doc;

        if (shownNotificationIds.contains(doc.id)) {
          continue;
        }

        shownNotificationIds.add(doc.id);
        _showAlertResponsePopup(doc);
      }
    });
  }

  Future<void> _showAlertResponsePopup(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    if (!mounted) {
      return;
    }

    final data = doc.data() ?? {};

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(data['title']?.toString() ?? 'Alert response'),
          content: Text(data['message']?.toString() ?? ''),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    await doc.reference.update({'isRead': true});
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 80,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      decoration:
          const BoxDecoration(
        color: Colors.white,
      ),

      child: Row(
        children: [

          Expanded(
            child: TextField(
              decoration:
                  InputDecoration(
                hintText:
                    'Search...',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor:
                    const Color(
                  0xFFF5F5F5,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('notifications')
                .where(
                  'userId',
                  isEqualTo:
                      FirebaseAuth.instance.currentUser?.uid ?? '',
                )
                .where('isRead', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              final count =
                  snapshot.data?.docs.length ?? 0;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor:
                            Colors.red,
                        child: Text(
                          count > 9 ? '9+' : '$count',
                          style:
                              const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.settings,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          const CircleAvatar(
            radius: 22,
            backgroundColor:
                Color(
              0xFFAF101A,
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
