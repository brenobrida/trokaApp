// Automatic troka imports
import '/backend/backend.dart';
import '/troka/troka_theme.dart';
import '/troka/troka_util.dart';
import 'index.dart'; // Imports other custom actions
import '/troka/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> offerMade(
  String userId,
  String objectId,
) async {
  final offersRef = FirebaseFirestore.instance.collection('offers');

  // Query for documents where the user is the one who offered
  final querySnapshotOffered = await offersRef
      .where('uidWhoOfferd',
          isEqualTo:
              userId) // Note the field name might be a typo; check your database structure.
      .where('objectInterestId', isEqualTo: objectId)
      .get();

  // Query for documents where the user is the one who received the offer
  final querySnapshotReceived = await offersRef
      .where('uidReceivedOffer', isEqualTo: userId)
      .where('objectOfferId', isEqualTo: objectId)
      .get();

  print('Querying with userId: $userId, objectId: $objectId');
  print('Documents found where offered: ${querySnapshotOffered.docs.length}');
  print('Documents found where received: ${querySnapshotReceived.docs.length}');

  // Check if a document was found in either query
  return querySnapshotOffered.docs.isNotEmpty ||
      querySnapshotReceived.docs.isNotEmpty;
}
