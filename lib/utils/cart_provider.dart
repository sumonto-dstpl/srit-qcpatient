import 'package:flutter/material.dart';
import '../Screens/Utils/user_secure_storage.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  bool isAdded(dynamic id) {
    return _items.any((e) => e['id'] == id);
  }

  int get count => _items.length;

  /// Load cart when screen starts (optional)
  Future<void> loadCart() async {
    String? username = await UserSecureStorage.getUsernameid();
    bool isGuest = await UserSecureStorage.getIfGuestLogged() == "YES";

    if (isGuest) username = "GUEST";

    // _items = await UserSecureStorage.getAddToCart("addToCart2", username ?? '');
    _items = (await UserSecureStorage.getAddToCart("addToCart2", username ?? ''))
        .cast<Map<String, dynamic>>();
    notifyListeners();
  }

  /// ADD item to cart
  Future<void> addItem(Map<String, dynamic> item) async {
    String? username = await UserSecureStorage.getUsernameid();
    bool isGuest = await UserSecureStorage.getIfGuestLogged() == "YES";

    if (isGuest) username = "GUEST";

    // Save to secure storage
    await UserSecureStorage.saveAddToCard(
      key: "addToCart2",
      userId: username ?? '',
      newData: item,
    );

    _items.insert(0, item);
    notifyListeners();
  }

  /// REMOVE item from cart
  Future<void> removeItem(dynamic id) async {
    String? username = await UserSecureStorage.getUsernameid();
    bool isGuest = await UserSecureStorage.getIfGuestLogged() == "YES";

    if (isGuest) username = "GUEST";

    List<dynamic> storageList =
    await UserSecureStorage.getAddToCart("addToCart2", username ?? '');

    int index = storageList.indexWhere((e) => e['id'] == id);

    if (index != -1) {
      await UserSecureStorage.deleteFromAddToCart(
        key: "addToCart2",
        userId: username ?? '',
        index: index,
      );
    }

    _items.removeWhere((e) => e['id'] == id);
    notifyListeners();
  }


  int get totalPrice {
    int price = 0;

    for (var item in _items) {
      int value = int.parse(item['qr'].toString().split(' ')[1]);
      price += value;
    }

    return price;
  }

}
