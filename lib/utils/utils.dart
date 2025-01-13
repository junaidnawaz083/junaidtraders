import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:junaidtraders/utils/constants.dart';

//   ----------------------  Colors  --------------------

Widget emptyScreen({
  String? title,
  required Widget body,
  Widget? floatingActionButton,
  FloatingActionButtonLocation? floatingActionButtonLocation,
  List<Widget>? leadingWidgets,
}) {
  return SafeArea(
    child: Scaffold(
      // backgroundColor: const Color.fromARGB(255, 33, 32, 32),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: title == null
          ? null
          : AppBar(
              title: titleText(text: title),
              actions: leadingWidgets,
            ),
      body: body,
    ),
  );
}

Widget titleText({required String text}) {
  return Text(text);
}

Widget getLable({
  required String text,
  TextStyle? slyle,
  bool? isUnderLined,
  FontWeight? fontWeight,
  double? fontSize,
  Color? color,
}) {
  return Text(
    text,
    style: slyle ??
        TextStyle(
          decoration: isUnderLined == true ? TextDecoration.underline : null,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 20,
          color: color ?? Colors.white,
        ),
  );
}

Widget dropDownField({
  required String? value,
  required List data,
  required Function onChange,
  bool? enabled,
  double? width,
  FocusNode? focus,
}) {
  return SizedBox(
    width: width ?? Get.width * 0.2,
    child: DropdownButtonFormField(
        focusNode: focus,
        isDense: true,
        decoration: InputDecoration(
          enabled: enabled ?? true,
          filled: true,
          fillColor: Colors.black87,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 175, 142, 129),
              width: 3,
            ),
          ),
        ),
        items: data
            .toSet()
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: getLable(
                  text: e,
                ),
              ),
            )
            .toList(),
        onChanged: (val) async {
          await onChange(val);
        }),
  );
}

Widget getTextFormField({
  double? width,
  bool? obscureText,
  required TextEditingController? controller,
  String? initialValue,
  FocusNode? focusNode,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  List<TextInputFormatter>? textInputFormatter,
  bool? isEnabled,
  int? maxLines = 1,
  int? minLines,
  bool expands = false,
  int? maxLength,
  void Function(String)? onChanged,
  void Function()? onTap,
  bool onTapAlwaysCalled = false,
  void Function(PointerDownEvent)? onTapOutside,
  void Function()? onEditingComplete,
  required Function(String) onFieldSubmitted,
  void Function(String?)? onSaved,
  required Function validator,
}) {
  return SizedBox(
    width: width ?? Get.width * 0.2,
    child: TextFormField(
      onChanged: onChanged,
      inputFormatters: textInputFormatter,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      controller: controller,
      autofocus: true,
      focusNode: focusNode,
      maxLines: maxLines ?? 1,
      enabled: isEnabled,
      validator: (txt) => validator(txt),
      textInputAction: textInputAction,
      onFieldSubmitted: (txt) async {
        await onFieldSubmitted(txt);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black87,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 175, 142, 129),
            width: 3,
          ),
        ),
      ),
    ),
  );
}

Widget getButton({
  double? width,
  double? height,
  required Function onPress,
  required String text,
  Color? buttonColor,
  double? borderRadius,
  bool? disabled,
  Color? borderColor,
  Color? textColor,
  FontWeight? fontWeight,
  double? fontSize,
}) {
  RxBool loading = false.obs;
  return SizedBox(
    height: height ?? 40,
    width: width,
    child: ElevatedButton(
      onPressed: () async {
        if (disabled == true) {
          return;
        }
        loading.value = true;
        await onPress();
        loading.value = false;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled == true
            ? const Color.fromARGB(255, 157, 156, 156)
            : buttonColor ?? Color.fromARGB(255, 175, 142, 129),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 7,
          ),
          side: BorderSide(
            color: borderColor ?? const Color.fromARGB(255, 157, 156, 156),
            width: 2,
          ),
        ),
      ),
      child: Obx(
        () => loading.value
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              )
            : getLable(
                text: text,
                color: disabled == true
                    ? Colors.black54
                    : textColor ?? Colors.black,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
      ),
    ),
  );
}

Widget getBigButton({
  double? width,
  double? height,
  required Function onPress,
  required String text,
  Color? buttonColor,
  double? borderRadius,
  Color? borderColor,
  Color? textColor,
  Widget? icon,
  FontWeight? fontWeight,
  double? fontSize,
}) {
  RxBool loading = false.obs;
  return SizedBox(
    height: height ?? Get.width * 0.07,
    width: width ?? Get.width * 0.1,
    child: ElevatedButton(
      onPressed: () async {
        loading.value = true;
        await onPress();
        loading.value = false;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Color.fromARGB(255, 175, 142, 129),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 7,
          ),
          side: BorderSide(
            color: borderColor ?? const Color.fromARGB(255, 157, 156, 156),
            width: 2,
          ),
        ),
      ),
      child: Obx(
        () => loading.value
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) icon,
                  getLable(
                    text: text,
                    color: textColor ?? Colors.black,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ],
              ),
      ),
    ),
  );
}

Future<void> showAlertDialog(
  BuildContext context, {
  required String title,
  String? content,
  required Function onYes,
  required Function onNo,
}) async {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Yes"),
    onPressed: () async {
      onYes();
    },
  );
  Widget noButton = TextButton(
    child: Text("No"),
    onPressed: () {
      onNo();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: getLable(
      text: title,
    ),
    content: content != null
        ? getLable(
            text: content,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          )
        : null,
    actions: [okButton, noButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
