import 'package:hejokeun/model/penukaran.dart';

class CartItem {
  final Penukaran penukaran;
  double quantity;

  CartItem({required this.penukaran, this.quantity = 0.1});
}
