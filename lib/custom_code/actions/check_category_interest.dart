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
import '/auth/firebase_auth/auth_util.dart';

Future<bool> checkCategoryInterest(
    List<String> categoriesInterest, String uid) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userObjects = firestore.collection('user_objects');

  // Cria uma query que busca documentos com o 'uid' igual ao do usuário e
  // 'objectCategory' dentro das categorias de interesse.
  Query query = userObjects
      .where('uid', isEqualTo: uid)
      .where('objectCategory', whereIn: categoriesInterest);

  // Executa a query e verifica se algum documento foi retornado.
  QuerySnapshot result = await query.get();
  return result.docs.isNotEmpty;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
