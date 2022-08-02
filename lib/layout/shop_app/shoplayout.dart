// ignore_for_file: unnecessary_import

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/shop_app/cartScreen/cartScreen.dart';
import '../../modules/shop_app/discountScreen/discountScreen.dart';
import '../../modules/shop_app/myOrderScreen/my_orders_screen.dart';
import '../../modules/shop_app/search/shop_searchScreen.dart';
import '../../modules/shop_app/settingScreen/addressesScreen.dart';
import '../../modules/shop_app/settingScreen/profileScreen.dart';
import '../../modules/shop_app/settingScreen/settingScreen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/statue.dart';

class ShopLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopCubit>(context)
        ..getProfileData()
        ..getFavoriteData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessHomeState)
            ShopCubit.get(context).cartModel!.data.cartItems.length;
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: const [
                  Text(
                    "ShopApp",
                  ),
                ],
              ),
              iconTheme: Theme.of(context).iconTheme,
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                          context, ShopSearchScreen(ShopCubit.get(context)));
                    },
                    icon: const Icon(
                      Icons.search,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: buildIconWithNumber(
                      condition: ShopCubit.get(context).totalCarts != 0,
                      icon: Icons.shopping_cart_outlined,
                      number: ShopCubit.get(context).totalCarts,
                      radius: 10,
                      fontSize: 12,
                      alignment: const Alignment(1, -0.8),
                      onPressed: () {
                        navigateTo(context, CartScreen());
                      }),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(spreadRadius: 1, blurRadius: 3),
                ],
              ),
              child: CurvedNavigationBar(
                height: 50,
                color: Theme.of(context).bottomAppBarColor,
                backgroundColor: Colors.black87,
                index: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: cubit.bottomItems,
              ),
            ),
            drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assests/images/shopapplogo.png'),
                  )),
                  child: null,
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Profile'),
                  onTap: () {
                    navigateTo(context, ProfileScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Addresses'),
                  onTap: () {
                    navigateTo(context, AddressesScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Orders'),
                  onTap: () {
                    navigateTo(context, const MyOrdersScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notification_important_outlined,
                  ),
                  title: const Text('Notification'),
                  onTap: () {},
                ),
                ListTile(
                    leading:
                        const Icon(Icons.local_offer_sharp, color: Colors.red),
                    title: const Text('Discounts %',
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      navigateTo(context, const DiscountScreen());
                    }),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    navigateTo(context, const SettingScreen());
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Contact Us '),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sign Out'),
                  onTap: () {
                    signOut(context);
                  },
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
