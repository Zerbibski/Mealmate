import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataStreams {
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  Stream<QuerySnapshot> get receipes {
    if (_uid != null) {
      return FirebaseFirestore.instance.collection('Receipe').snapshots();
    } else {
      // Retourner un Stream vide si l'utilisateur n'est pas connecté
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> get fridge {
    if (_uid != null) {
      return FirebaseFirestore.instance
          .collection('Clients')
          .doc(_uid)
          .collection('Fridge')
          .snapshots();
    } else {
      // Retourner un Stream vide si l'utilisateur n'est pas connecté
      return const Stream.empty();
    }
  }
}
