// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class BasketModel {
  String? uuid;
  String? name;
  int? cost;
  bool? automated;
  String? speculator_id;
  int? deposit_amount;
  String? waddress;
  List<dynamic>? users;
  // ignore: non_constant_identifier_Basket
  BasketModel(
      {this.uuid,
      this.name,
      this.cost,
      this.automated,
      this.speculator_id,
      this.deposit_amount,
      this.waddress,
      this.users
      });

  // receiving data from server
  factory BasketModel.fromMap(map) {
    return BasketModel(
      uuid: map["uuid"],
      name: map["name"],
      cost: map["cost"],
      automated: map["automated"],
      speculator_id: map["speculator_id"],
      deposit_amount: map["deposit_amount"],
      waddress: map["waddress"],
      users: map["users"],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'cost': cost,
      'automated': automated,
      'speculator_id': speculator_id,
      'deposit_amount': deposit_amount,
      'waddress': waddress,
      'users': users,
    };
  }

}
