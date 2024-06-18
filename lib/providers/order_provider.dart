import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../order_model.dart';

const _uuid = Uuid();

final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super([]) {
    _loadOrders();
  }

  Box<Order> get _orderBox => Hive.box<Order>('orders');

  void _loadOrders() async {
    final orders = _orderBox.values.toList();
    state = orders;
  }

  void addOrder(
    String order,
    String description,
    DateTime date,
  ) async {
    final newDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final newOrder = Order(
      order: order,
      description: description,
      date: newDate,
      isCompleted: false,
      uuid: state.isEmpty ? 1 : state.last.uuid + 1,
    );

    await _orderBox.put(newOrder.uuid, newOrder);
    state = [...state, newOrder];
    _loadOrders();
  }

  void removeOrder(key) async {
    await _orderBox.delete(key);
    _loadOrders();
  }

  void toggleCompletionStatus(uuid) {
    final order = state.firstWhere((element) => element.uuid == uuid);
    order.isCompleted = !order.isCompleted;
    _orderBox.put(order.uuid, order);
    _loadOrders();
  }

  void deleteAll() async {
    await _orderBox.clear();
    _loadOrders();
  }

  List<DateTime> getAllBookedDates() {
    Set<DateTime> datesSet = {};
    for (Order order in state) {
      datesSet.add(order.date);
    }
    List<DateTime> datesList = datesSet.toList();
    datesList.sort();
    return datesList;
  }

  List<Order> getOrdersByDate(DateTime date) {
    List<Order> orders = [];
    for (Order order in state) {
      if (order.date == date) {
        orders.add(order);
      }
    }
    return orders;
  }

  int getDateIndex(date) {
    List<DateTime> dates = getAllBookedDates();
    for (int i = 0; i < dates.length; i++) {
      if (dates[i] == date) {
        return i;
      }
    }
    return -1;
  }

  void editOrder(Order order) async {
    await _orderBox.put(order.uuid, order);
    _loadOrders();
  }
}

final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());
