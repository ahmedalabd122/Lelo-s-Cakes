import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/models/order_model.dart';
import 'package:lelos_orders_app/providers/images_provider.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';

class GalleryView extends ConsumerWidget {
  GalleryView({
    super.key,
    this.images,
    this.isPicker = true,
    this.order,
    this.crossAxisCount = 3,
  });

  List<String>? images;
  bool isPicker = true;
  Order? order;
  int crossAxisCount = 3;
  @override
  Widget build(BuildContext context, ref) {
    final galleryImages = ref.watch(imagePickerProvider(images));
    final orderView = ref.watch(orderProvider);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: galleryImages.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return InteractiveViewer(
          clipBehavior: Clip.none,
          panEnabled: false,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(
                    galleryImages[index],
                  ),
                ),
              ),
            ),
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                if (isPicker) {
                  ref
                      .read(imagePickerProvider(images).notifier)
                      .removeImage(galleryImages[index]);
                } else {
                  galleryImages.removeAt(index);
                  Order newOrder = order!.copyWith(images: galleryImages);
                  ref.read(orderProvider.notifier).editOrder(newOrder);
                }
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
        );
      },
    );
  }
}
