import 'package:hejokeun/utils/constants.dart';
import 'package:flutter/material.dart';

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({super.key, required this.screenImageName});
  final String screenImageName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/$screenImageName',
          width: 165.38,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: kDarkBrown,
        fontSize: kH5,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      // required this.onPressed,
      this.buttonColor,
      this.textColor,
      this.isOutlined = false,
      this.width = 326,
      this.height = 40});

  final String buttonText;
  // final Function() onPressed;
  final bool isOutlined;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // onPressed;
        },
        child: Material(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.white,
              border: isOutlined ? Border.all(color: kAG1) : null,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: kBS3,
                  color: textColor ?? kAG1,
                ),
              ),
            ),
          ),
        ));
  }
}

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.fieldText,
    required this.labelText,
    required this.controller,
    required this.textInputAction,
    required this.textInputType,
  });

  final String fieldText;
  final String labelText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldText,
            style: const TextStyle(
              color: kAG0,
              fontSize: kBS3,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: labelText,
              labelStyle: const TextStyle(
                color: kLabel,
                fontSize: kBR3,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            style: const TextStyle(
              color: kAG1,
              fontSize: kBR3,
            ),
          ),
        ],
      ),
    );
  }
}
