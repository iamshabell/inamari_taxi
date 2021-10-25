import 'package:flutter/cupertino.dart';
import 'package:inamari/models/address_model.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation;

  void updatePickUpAdress(Address pickUpAdress) {
    pickUpLocation = pickUpAdress;
    notifyListeners();
  }
}
