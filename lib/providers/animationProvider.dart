import 'package:flutter_riverpod/flutter_riverpod.dart';

final animationStartProvider = StateProvider<bool>((ref) => false);

final animationIndexProvider =
    StateNotifierProvider<animationIndexNotifier, int>(
        (ref) => animationIndexNotifier());

class animationIndexNotifier extends StateNotifier<int> {
  animationIndexNotifier() : super(0) {
    state = 0;
  }

  void setIndex(int index) {
    state = index;
  }

  int getIndex() {
    int index = state;
    state++;
    return index++;
  }

  void incrementIndex() {
    int index = state;
    index++;
    state = index;
  }
}
