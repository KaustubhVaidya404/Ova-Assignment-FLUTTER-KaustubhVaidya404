
import 'package:flutter/material.dart';

class InterConnection extends ChangeNotifier {

  String? roomId;

  void setRoomId(String id) {
    roomId = id;
    notifyListeners();
  }

}
