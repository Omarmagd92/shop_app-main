import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/addressModels/address_model.dart';
import '../../../shared/components/components.dart';
import '../myOrderScreen/my_orders_screen.dart';
import 'add&UpdateAddress.dart';

// ignore: must_be_immutable
class AddressesScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();

  AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is AddOrderSuccessState) {
          if (state.addOrderModel.status) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.SCALE,
              title: 'Your Order in progress',
              desc:
                  "Your order was placed successfully.\n For more details check Delivery Status in settings.",
              btnOkText: "Order",
              btnOkOnPress: () {
                Navigator.pop(context);
                // ShopCubit.get(context).OnChangeTabs(3);
                navigateTo(context, MyOrdersScreen());
              },
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnCancelText: "Home",
              btnCancelColor: Colors.red,
              btnOkIcon: Icons.list_alt_outlined,
              btnCancelIcon: Icons.home,
              width: 400,
            ).show();
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            centerTitle: true,
            leading: const Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            title: Row(
              children: const [
                Text('Location'),
              ],
            ),
          ),
          bottomNavigationBar: VAvigatonbar(
            context,
            cubit.addressModel!.data!.data!.isEmpty
                ? null
                : cubit.addressModel!.data!.data!.first,
          ),
          body: cubit.addressModel!.data!.data!.isEmpty
              ? const Center(
                  child: Text(
                  'Please add New Address 🙁',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ))
              : cubit.addressModel!.data!.data!.isEmpty
                  ? const Center(
                      child: Text(
                      'Please add New Address 🙁',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ))
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          buildLocationItem(
                              cubit.addressModel!.data!.data![index], context),
                      itemCount: cubit.addressModel!.data!.data!.length,
                    ),
        );
      },
    );
  }
}

Widget buildLocationItem(AddressData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name :   ${model.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              UpdateAddressScreen(
                                isEdit: true,
                                addressId: model.id,
                                name: model.name,
                                city: model.city,
                                region: model.region,
                                details: model.details,
                                notes: model.notes,
                              ));
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'city      :   ${model.city}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'region :   ${model.region}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'details :   ${model.details}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'notes   :   ${model.notes}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          ShopCubit.get(context)
                              .deleteAddress(addressId: model.id);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 20,
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget VAvigatonbar(context, AddressData? model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: model == null
          ? primaryButton(
              height: 50,
              onPressed: () {
                navigateTo(
                    context,
                    UpdateAddressScreen(
                      isEdit: false,
                    ));
              },
              text: 'Add New Addresses',
            )
          : primaryButton(
              height: 50,
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.QUESTION,
                  animType: AnimType.SCALE,
                  title: 'Are you Sure for Confirm this Order ?',
                  btnOkOnPress: () {
                    ShopCubit.get(context).addNewOrder(addressId: model.id);
                  },
                  btnCancelText: "Cancel",
                  btnCancelOnPress: () {},
                ).show();
              },
              text: 'Order Now',
            ),
    );
