import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/core/constants/app_assets.dart';
import 'package:smart_gift_finder/feature/account/peresentation/view/screens/account_screen.dart';
import 'package:smart_gift_finder/feature/ai_finder/peresentation/view/screens/ai_finder_screen.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view/widgets/nav_icon.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view_model/app_section_cubit.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view_model/app_section_states.dart';
import 'package:smart_gift_finder/feature/cart/peresentation/view/screens/cart_screen.dart';
import 'package:smart_gift_finder/feature/home/peresentation/view/screens/home_screen.dart';
import 'package:smart_gift_finder/feature/wishlist/peresentation/view/screens/wish_list.dart';

class AppSectionScreen extends StatefulWidget {
  const AppSectionScreen({super.key});
  @override
  State<AppSectionScreen> createState() => _AppSectionScreenState();
}
class _AppSectionScreenState extends State<AppSectionScreen> {
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
                    path: AppAssets.shippingAddressIcon,
                    index: 2,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.savedIcon,
                    index: 3,
                    currentIndex: cubit.currentIndex,
                  ),
                  label: "Wishlist",
                ),
                BottomNavigationBarItem(
                  icon: NavIcon(
                    path: AppAssets.userProfilePhotoIcon,
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
