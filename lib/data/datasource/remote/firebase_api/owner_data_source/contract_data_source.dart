// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../model/contract_model.dart';
//
// @lazySingleton
// class ContractRemoteDataSource {
//   final FirebaseFirestore _firestore;
//
//   ContractRemoteDataSource(this._firestore);
//
//   CollectionReference get _contractsCollection =>
//       _firestore.collection('contracts');
//
//   Future<ContractModel> createContract(ContractModel model) async {
//     final docRef = model.id.isNotEmpty
//         ? _contractsCollection.doc(model.id)
//         : _contractsCollection.doc();
//
//     final toSave = ContractModel(
//       id: docRef.id,
//       bookingId: model.bookingId,
//       roomId: model.roomId,
//       ownerId: model.ownerId,
//       tenantId: model.tenantId,
//       startDate: model.startDate,
//       endDate: model.endDate,
//       durationMonth: model.durationMonth < 3 ? 3 : model.durationMonth,
//       monthlyRent: model.monthlyRent,
//       description: model.description,
//       createdAt: model.createdAt,
//     );
//
//     await docRef.set(toSave.toFirestore());
//     final doc = await docRef.get();
//     return ContractModel.fromFirestore(doc);
//   }
//
//   Future<ContractModel?> getContractByBookingId(String bookingId) async {
//     if (bookingId.isEmpty) return null;
//     final snap = await _contractsCollection
//         .where('bookingId', isEqualTo: bookingId)
//         .limit(1)
//         .get();
//
//     if (snap.docs.isEmpty) return null;
//     return ContractModel.fromFirestore(snap.docs.first);
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:rental_room/data/data.dart';

@lazySingleton
class ContractRemoteDataSource {
  final FirebaseFirestore _firestore;

  ContractRemoteDataSource(this._firestore);

  CollectionReference get _contractsCollection =>
      _firestore.collection('contracts');

  Future<ContractModel> createContract(ContractModel model) async {
    final docRef = model.id.isNotEmpty
        ? _contractsCollection.doc(model.id)
        : _contractsCollection.doc();

    final toSave = ContractModel(
      id: docRef.id,
      bookingId: model.bookingId,
      roomId: model.roomId,
      ownerId: model.ownerId,
      tenantId: model.tenantId,
      startDate: model.startDate,
      endDate: model.endDate,
      durationMonth: model.durationMonth < 3 ? 3 : model.durationMonth,
      monthlyRent: model.monthlyRent,
      description: model.description,
      status: model.status,
      createdAt: model.createdAt,
    );

    await docRef.set(toSave.toFirestore());
    final doc = await docRef.get();
    return ContractModel.fromFirestore(doc);
  }

  Future<ContractModel?> getContractByBookingId(String bookingId) async {
    if (bookingId.isEmpty) return null;
    final snap = await _contractsCollection
        .where('bookingId', isEqualTo: bookingId)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;
    return ContractModel.fromFirestore(snap.docs.first);
  }

  /// Gets all contracts for a specific owner ID
  Future<List<ContractModel>> getContractsByOwnerId(String ownerId) async {
    if (ownerId.isEmpty) return [];
    final snap = await _contractsCollection
        .where('ownerId', isEqualTo: ownerId)
        .get();

    return snap.docs.map((doc) => ContractModel.fromFirestore(doc)).toList();
  }

  /// Updates an existing contract document in Firestore
  Future<ContractModel> updateContract(ContractModel model) async {
    final docRef = _contractsCollection.doc(model.id);

    await docRef.update(model.toFirestore());

    final updatedDoc = await docRef.get();
    return ContractModel.fromFirestore(updatedDoc);
  }
}