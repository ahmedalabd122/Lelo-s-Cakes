import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/models/order_model.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';

final filePathsProvider =
    StateNotifierProvider<FilePathsNotifier, List<String>>(
        (ref) => FilePathsNotifier(ref));

class FilePathsNotifier extends StateNotifier<List<String>> {
  FilePathsNotifier(this.ref) : super([]);
  StateNotifierProviderRef ref;

  void getAllPaths() {
    List<Order> orders = ref.watch(orderProvider.notifier).state;
    Set<String> paths = {};
    for (var order in orders) {
      for (var image in order.images) {
        paths.add(image);
      }
    }
    state = [...state];
  }
}
