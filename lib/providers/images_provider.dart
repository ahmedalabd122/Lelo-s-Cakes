import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = StateNotifierProvider.family
    .autoDispose<CustomMultiImagePicker, List<String>, List<String>?>((
  ref,
  initState,
) {
  return CustomMultiImagePicker(
    initState: initState,
  );
});

class CustomMultiImagePicker extends StateNotifier<List<String>> {
  CustomMultiImagePicker({
    this.initState,
  }) : super([]) {
    state = initState ?? [];

    log(state.length.toString());
  }
  final picker = ImagePicker();
  List<String>? initState;
  Future<void> pickImages() async {
    List<String> selectedPaths = [];
    final pickedFile = await picker.pickMultiImage(
      requestFullMetadata: true,
      imageQuality: 100,
    );
    if (pickedFile.isNotEmpty) {
      for (var i = 0; i < pickedFile.length; i++) {
        selectedPaths.add(pickedFile[i].path);
      }
      state = [...state, ...selectedPaths];
    }
  }

  void addImage() {}

  Future<void> removeImage(String path) async {
    if (state.isEmpty) return;
    state.remove(path);
    state = [...state];
  }

  void clearState() {
    state = [];
  }
}
