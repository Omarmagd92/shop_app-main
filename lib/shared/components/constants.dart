//post
//update
//delete
//get

//base url: https://newsapi.org/

//method(url) :v2/top-headlines?

//queries:country=us&category=business&apiKey=60e05259eb3c4d18b5909df4360c5c51

//search url https://newsapi.org/v2/everything?q=tesla&t&apiKey=60e05259eb3c4d18b5909df4360c5c51

import 'package:intl/intl.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../modules/shop_app/shop_login/cubit/statues.dart';
import '../../modules/shop_app/shop_login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

dynamic signOut(context) async {
  await CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
      ShopCubit.get(context).currentIndex = 0;
    }
  });
}

void printFullText(dynamic text) {
  final pattern = RegExp('.{1,800}'); //800 size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
String? uId = '';
int cartLength = 0;
int favLength = 0;
dynamic discountLen = 0;

String getDateTomorrow() {
  DateTime dateTime = DateTime.now().add(Duration(days: 1));
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}

bool isEdit = false;
String editText = 'Edit';

void editPressed({
  required context,
  required email,
  required name,
  required phone,
}) {
  isEdit = !isEdit;
  if (isEdit) {
    editText = 'Save';
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    ShopCubit.get(context).emit(EditPressedState());
  } else {
    editText = 'Edit';
    ShopCubit.get(context)
        .updateProfileData(email: email, name: name, phone: phone);
  }
}
