import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    textColor: ColorStyles.mainColor,
    fontSize: 16,
  );
}
