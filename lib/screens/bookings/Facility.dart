import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Facility
{


final String Category;
  final String ContactNum;
  final String Name;
  final int PricePP;
final String DocIdFac;
  Facility({ this.Category, this.ContactNum, this.Name, this.PricePP,this.DocIdFac});
}