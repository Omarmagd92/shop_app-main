import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/user_model/faqsModels.dart';
import '../../../shared/components/components.dart';

class FAQsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  Text('Shop App'),
                ],
              ),
            ),
            body: state is FAQsLoadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: Colors.grey[300],
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'FAQs',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => faqsItemBuilder(
                                cubit.faqsModel.data!.data![index]),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: cubit.faqsModel.data!.data!.length),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget faqsItemBuilder(FAQsData model) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.question}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.answer}',
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
