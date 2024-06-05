import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

double? getLat(LatLng? latlng) {
  return latlng?.latitude;
}

double? getLng(LatLng? latlng) {
  return latlng?.longitude;
}

bool findSugestion(
  String objectCategory,
  List<String>? objectCategoryInterest,
  bool? anyCategory,
  String uid,
  String objectId,
) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userObjects = firestore.collection('user_objects');
  CollectionReference systemSugestions =
      firestore.collection('system_sugestions');

  Query query = userObjects.where('uid', isNotEqualTo: uid);

  if (anyCategory == true) {
    query =
        query.where('objectCategoryInterest', arrayContains: objectCategory);
  } else if (objectCategoryInterest != null &&
      objectCategoryInterest.isNotEmpty) {
    query = query.where('objectCategory', whereIn: objectCategoryInterest);
  }

  query.snapshots().listen((snapshot) {
    for (var doc in snapshot.docs) {
      Map<String, dynamic>? data =
          doc.data() as Map<String, dynamic>?; // Correct type casting

      if (data != null) {
        String? docObjectId = data?.containsKey('objectId') == true
            ? data['objectId'] as String?
            : null;
        if (docObjectId != objectId) {
          // Check to ensure not self-matching
          // Check if the document already exists in the system_suggestions collection
          systemSugestions
              .where('objectInterestId', isEqualTo: data['objectId'] as String?)
              .where('objectId', isEqualTo: objectId)
              .limit(1)
              .get()
              .then((existingDocs) {
            if (existingDocs.docs.isEmpty) {
              // No existing document with the same objectInterestId and objectId
              systemSugestions.add({
                'objectInterestCategory': data['objectCategory'] as String?,
                'objectInterestBairro': data['bairro'] as String?,
                'objectInterestCidade': data['cidade'] as String?,
                'objectInterestConditions': data['objectConditions'] as String?,
                'objectInterestPhoto': data['photo1'] as String?,
                'objectInterestTitle': data['title'] as String?,
                'objectInterestId': data['objectId'] as String?,
                'uidObjectInterest': data['uid'] as String,
                'objectId': objectId
              });
            } // Else, do not add since it already exists
          });
        }
      }
    }
  });

  return true;
}

bool? compareTwoStringLists(
  List<String>? list1,
  List<String>? list2,
) {
  if (list1 == null || list2 == null) return true;

  var set1 = list1.toSet();

  for (var item in list2) {
    if (set1.contains(item)) {
      return true;
    }
  }
  return false;
}

bool checkCPF(String cpf) {
  var numbers = cpf.replaceAll(RegExp(r'\D'), '');

  if (numbers.length != 11) return false;

  // Known invalid numbers
  if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) return false;

  List<int> digits = numbers.split('').map((String d) => int.parse(d)).toList();

  int calculateChecksum(int sliceEnd, int multiplier) {
    var sum = 0;
    for (int i = 0; i < sliceEnd; i++) {
      sum += digits[i] * (multiplier - i);
    }
    var remainder = (sum * 10) % 11;
    return remainder == 10 ? 0 : remainder;
  }

  int firstDigit = calculateChecksum(9, 10);
  int secondDigit = calculateChecksum(10, 11);

  return firstDigit == digits[9] && secondDigit == digits[10];
}
