import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/changeThemeButton/changeThemeButton.dart';
import '../search/helpScreen.dart';
import 'UserProfile.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome ${cubit.userModel!.data!.name!.split(' ').elementAt(0)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${cubit.userModel!.data!.email}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'MY ACCOUNT',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )),
                InkWell(
                  onTap: () {
                    // navigateTo(context, AddressesScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Addresses',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {
                    navigateTo(context, UserProfile());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'SETTINGS',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          '  Night Mode',
                          style: TextStyle(color: Color(0xffbb86fc)),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        SwitchWidget(),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Country',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text('Egypt'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Language',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text('English'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.arrow_forward_ios_rounded),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'REACH OUT TO US',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )),
                InkWell(
                  onTap: () {
                    ShopCubit.get(context).getFAQsData();
                    navigateTo(context, FAQsScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'FAQs',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                myDivider(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: () {
                      signOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'SignOut',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
