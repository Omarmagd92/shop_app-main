import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/categoriesDetailsModel.dart';
import '../../../shared/components/components.dart';
import '../product_details/productDeatils.dart';
import '../search/shop_searchScreen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;

  CategoryProductsScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                Text('Shop App'),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(
                        context, ShopSearchScreen(ShopCubit.get(context)));
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: state is CategoryDetailsLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ShopCubit.get(context)
                          .categoriesDetailModel!
                          .data
                          .productData
                          .length ==
                      0
                  ? Center(
                      child: Text(
                        'Coming Soon',
                        style: TextStyle(fontSize: 50),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  '$categoryName',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                  ShopCubit.get(context)
                                      .categoriesDetailModel!
                                      .data
                                      .productData
                                      .length,
                                  (index) => ShopCubit.get(context)
                                              .categoriesDetailModel!
                                              .data
                                              .productData
                                              .length ==
                                          0
                                      ? Center(
                                          child: Text(
                                            'Coming Soon',
                                            style: TextStyle(fontSize: 50),
                                          ),
                                        )
                                      : productItemBuilder(
                                          ShopCubit.get(context)
                                              .categoriesDetailModel!
                                              .data
                                              .productData[index],
                                          context)),
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Widget productItemBuilder(ProductData model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductData(model.id);
        navigateTo(context, ProductDetails());
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 150,
                width: 150,
              ),
              if (model.discount != 0)
                Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Discount',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ))
            ]),
            SizedBox(
              height: 6,
            ),
            Text(
              '${model.name}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'EGP  ',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  if (model.discount != 0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'EGP',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${model.discount}' + '% OFF',
                          style: TextStyle(color: Colors.red, fontSize: 11),
                        )
                      ],
                    ),
                ]),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
