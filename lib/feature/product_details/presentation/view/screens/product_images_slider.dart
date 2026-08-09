import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductImagesSlider extends StatefulWidget {
  final List<String> images;

  const ProductImagesSlider({super.key, required this.images});

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 300,
        color: const Color(0xFFF5F5F5),
        child: const Center(
            child:
                Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: const Color(0xFFF5F5F5),
          width: double.infinity,
          height: 300,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 280.0,
              viewportFraction: 1.0,
              enableInfiniteScroll: widget.images.length > 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
            items: widget.images.map((imgUrl) {
              return Image.network(
                imgUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey),
              );
            }).toList(),
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return Container(
                  width: _currentImageIndex == entry.key ? 10.0 : 6.0,
                  height: _currentImageIndex == entry.key ? 10.0 : 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == entry.key
                        ? const Color(0xFF4D39E9)
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
