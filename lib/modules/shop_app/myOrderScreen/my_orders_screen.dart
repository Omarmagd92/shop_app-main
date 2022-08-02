import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/cartModels/order_model.dart';
import '../../../shared/components/components.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is CancelOrderSuccessState) {
          if (state.cancelOrderModel.status) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.SCALE,
              title: 'Order has been Cancelled.',
              desc: "Your order was cancelled successfully!",
              btnOkOnPress: () {},
            ).show();
          } else {}
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              children: const [
                Text(
                  'Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).orderModel!.data.data.isNotEmpty,
            builder: (context) => ConditionalBuilder(
              condition: ShopCubit.get(context).ordersDetails.isNotEmpty,
              // state is! CancelOrderLoadingState,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => buildOrderItem(
                          ShopCubit.get(context).ordersDetails[index].data,
                          context,
                          state),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: ShopCubit.get(context).ordersDetails.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            fallback: (context) => buildNoOrders(context),
          ),
        );
      },
    );
  }

  Widget buildOrderItem(OrderDetailsData model, context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Order ID:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.id.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      model.date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Cost : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.cost)} LE",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "VAT : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.vat)} LE",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Text(
                      "Total Amount : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.total)} LE",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.status,
                      style: TextStyle(
                        color:
                            (model.status == "New") ? Colors.green : Colors.red,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    if (model.status == "New")
                      primaryButton(
                        text: "Cancel",
                        width: 110,
                        height: 30,
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            animType: AnimType.SCALE,
                            title: 'Are you Sure for Cancel Order ?',
                            btnOkOnPress: () {
                              ShopCubit.get(context).cancelOrder(id: model.id);
                            },
                            btnCancelOnPress: () {},
                          ).show();
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildNoOrders(context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.list_alt_outlined,
                size: 60,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You have no orders in progress!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'All your orders will be saved here for you to access their state anytime',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: primaryButton(
                  text: "Start Shopping",
                  onPressed: () {
                    ShopCubit.get(context).changeBottomNav(0);
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      );
}
