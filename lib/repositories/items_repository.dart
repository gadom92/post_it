import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('2CEzxyKK81RsNmSCFXKw0Tf17Vk2')
        .collection('notes')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ItemModel(
          note: doc['note'],
          id: doc.id,
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('2CEzxyKK81RsNmSCFXKw0Tf17Vk2')
        .collection('notes')
        .doc(id)
        .delete();
  }

  Future<void> add({required String text}) async {
   await FirebaseFirestore.instance
        .collection('users')
        .doc('2CEzxyKK81RsNmSCFXKw0Tf17Vk2')
        .collection('notes')
        .add(
          ({
            'note': text,
          }),
        );
  }
}
