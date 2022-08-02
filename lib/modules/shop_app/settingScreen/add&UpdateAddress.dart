import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../shared/components/components.dart';
import '../cartScreen/cartScreen.dart';
import '../search/shop_searchScreen.dart';

// ignore: must_be_immutable
class UpdateAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;

  UpdateAddressScreen({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is UpdateAddressSuccessState) {
          if (state.addressModel.status) Navigator.pop(context);
        } else if (state is AddAddressSuccessState) if (state
            .addressModel.status) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (isEdit) {
          nameControl.text = name!;
          cityControl.text = city!;
          regionControl.text = region!;
          detailsControl.text = details!;
          notesControl.text = notes!;
        }
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
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: addressFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is AddAddressLoadingState ||
                          state is UpdateAddressLoadingState)
                        Column(
                          children: const [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      const Text(
                        'LOCATION INFORMATION',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: nameControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter your Location name',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'City',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: cityControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter your City name',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Region',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: regionControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter your region',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Details',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: detailsControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter some details',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Notes',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: notesControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please add some notes to help find you',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                            onPressed: () {
                              if (addressFormKey.currentState!.validate()) {
                                if (isEdit) {
                                  ShopCubit.get(context).updateAddress(
                                    name: nameControl.text,
                                    city: cityControl.text,
                                    region: regionControl.text,
                                    details: detailsControl.text,
                                    notes: notesControl.text,
                                  );
                                } else {
                                  ShopCubit.get(context).addAddress(
                                    name: nameControl.text,
                                    city: cityControl.text,
                                    region: regionControl.text,
                                    details: detailsControl.text,
                                    notes: notesControl.text,
                                  );
                                }
                              }
                            },
                            color: Colors.purple.shade200,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              'SAVE ADDRESS',
                              style: TextStyle(fontSize: 15),
                            )),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
