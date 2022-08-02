import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/changeThemeButton/changeThemeButton.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextButton(
            //onPressed: () {  },
            // child: Text( 'Language',),

            // ),
            Row(
              children: [
                Icon(
                  Icons.dark_mode_outlined,
                ),
                Text(
                  '  Night Mode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  width: 155,
                ),
                SwitchWidget(),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            myDivider(),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.map_outlined,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Country',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            SizedBox(
              height: 15,
            ),
            myDivider(),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.flag_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Language',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
          ],
        ),
      ),
    );
  }
}
