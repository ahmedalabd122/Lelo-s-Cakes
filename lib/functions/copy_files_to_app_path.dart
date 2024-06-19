import 'dart:developer';
import 'dart:io';

import 'package:lelos_orders_app/models/order_model.dart';
import 'package:path_provider/path_provider.dart';

Future<List<String>> copyFilesToAppPath(List<String> files) async {
  final appPath = await getApplicationDocumentsDirectory();
  final localPath = appPath.path;

  List<String> copiedFiles = [];
  for (var file in files) {
    if (copiedFiles.contains(file)) continue;
    List<String> pathParts = file.split('/');

    await File(file)
        .copy('$localPath/${pathParts[pathParts.length - 2]}${pathParts.last}');
    copiedFiles
        .add('$localPath/${pathParts[pathParts.length - 2]}${pathParts.last}');
    log('$localPath/${pathParts[pathParts.length - 2]}${pathParts.last}');
    log(file);
  }
  return copiedFiles;
}

Future<void> deleteUnusedFiles(List<Order> orders) async {
  for (var order in orders) {
    log(order.images.length.toString());
    Set imageSet = Set.from(order.images);
    log(imageSet.length.toString());
    for (var image in imageSet) {
      await File(image).delete();
    }
  }
}

Future<void> clearAppPath(List<String> paths) async {
  for(var path in paths) {
    await deleteFile(path);
  }
}

Future<void> deleteFile(path) async {
  await File(path).delete();
}
