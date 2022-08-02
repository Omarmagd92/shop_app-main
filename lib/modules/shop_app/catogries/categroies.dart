import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/catogery_model.dart';
import '../../../shared/components/components.dart';
import 'categoryProductsScreen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, statue) {},
      builder: (context, statue) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCategoriesItem(
              ShopCubit.get(context).categoriesModel!.data.data[index],
              context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoriesDetailData(model.id);
        navigateTo(context, CategoryProductsScreen(model.name));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
