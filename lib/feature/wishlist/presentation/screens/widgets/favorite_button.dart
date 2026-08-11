import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/wishlist_cubit.dart';
import '../../cubit/wishlist_state.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;
  final String userId;
  final Map<String, dynamic>? productData;

  const FavoriteButton({
    super.key,
    required this.productId,
    required this.userId,
    this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final isFav = context.read<WishlistCubit>().isFavorite(productId);

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              context.read<WishlistCubit>().toggleFavorite(
                    userId: userId,
                    productId: productId,
                    productData: productData,
                  );
            },
          ),
        );
      },
    );
  }
}
