import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/core/constants/app_assets.dart';
import 'package:smart_gift_finder/feature/account/presentation/screens/account_screen.dart';
import 'package:smart_gift_finder/feature/ai_finder/peresentation/view/screens/ai_finder_screen.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view/widgets/nav_icon.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view_model/app_section_cubit.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view_model/app_section_states.dart';
import 'package:smart_gift_finder/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:smart_gift_finder/feature/cart/presentation/screens/cart_screen.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';
import 'package:smart_gift_finder/feature/home/presentation/view/screens/home_screen.dart';
import 'package:smart_gift_finder/feature/wishlist/peresentation/view/screens/wish_list.dart';

class AppSectionScreen extends StatefulWidget {
  const AppSectionScreen({super.key});
  @override
  State<AppSectionScreen> createState() => _AppSectionScreenState();
}

class _AppSectionScreenState extends State<AppSectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CartCubit>().loadCart();
      context.read<AccountCubit>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSectionCubit(),
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          final cubit = context.read<AppSectionCubit>();
          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: const [
                HomeScreen(),
                AIFinderScreen(),
                CartScreen(),
                WishListScreen(),
                AccountScreen(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (value) => cubit.changeTab(value),
              items: [
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.homeIcon,
                    index: 0,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.aiIcon,
                    index: 1,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "AI Finder",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.cartIcon,
                    index: 2,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.favoriteIcon,
                    index: 3,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Wishlist",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.profilePhotoIcon,
                    index: 4,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Account",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
