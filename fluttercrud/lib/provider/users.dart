import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_agtech/data/dummy_users.dart';
import 'package:projeto_agtech/models/users.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...dummyUers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User? user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id!,
        (_) => User(
            id: user.id,
            name: user.name,
            email: user.email,
            avatar: user.avatar),
      );
    } else {
      // adicionar users
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatar: user.avatar,
        ),
      );
    }
    notifyListeners();
  }

  // Remover users
  void remove(User user) {
    if (user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
