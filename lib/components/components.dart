import 'package:hejokeun/utils/constants.dart';
import 'package:flutter/material.dart';

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({
    super.key,
    required this.screenImageName,
    this.width,
    this.height,
  });

  final String screenImageName;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/$screenImageName',
        width: width,
        height: height,
        fit: BoxFit.contain,
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
      style: kH5.copyWith(
        color: kDarkBrown,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.isOutlined = false,
    this.width = 326,
    this.height = 40,
    this.isDisabled = false,
  });

  final String buttonText;
  final Function onPressed;
  final bool isOutlined;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color? textColor;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Material(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: isDisabled
                  ? kDisabledBtn.withOpacity(0.12)
                  : buttonColor ?? Colors.white,
              border: isOutlined ? Border.all(color: kAG1) : null,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: isDisabled
                  ? Text(
                      buttonText,
                      style: kBS3.copyWith(
                        color: kDisabledBtn.withOpacity(0.38),
                      ),
                    )
                  : Text(
                      buttonText,
                      style: kBS3.copyWith(
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
    this.required,
    this.obscureText,
    this.suffixIcon,
    this.focusNode,
    this.autofocus,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.borderColor,
  });

  final String fieldText;
  final String labelText;
  final bool? required;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: fieldText,
              style: kBS3.copyWith(
                color: kAG0,
              ),
              children: [
                TextSpan(
                  text: required == true ? ' *' : '',
                  style: kBR3.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            autofocus: autofocus ?? false,
            validator: validator,
            obscureText: obscureText ?? false,
            obscuringCharacter: '*',
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: labelText,
              labelStyle: kBR3.copyWith(
                color: kLabel,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: borderColor ?? kAG2,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: kAG1,
                  width: 1.2,
                ),
              ),
            ),
            style: kBR3.copyWith(
              color: kAG1,
            ),
          ),
        ],
      ),
    );
  }
}

class AppPhoneFormField extends StatelessWidget {
  const AppPhoneFormField({
    super.key,
    required this.fieldText,
    required this.labelText,
    required this.controller,
    required this.textInputAction,
    required this.textInputType,
    this.required,
    this.obscureText,
    this.suffixIcon,
    this.focusNode,
    this.autofocus,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
  });

  final String fieldText;
  final String labelText;
  final bool? required;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: fieldText,
              style: kBS3.copyWith(
                color: kAG0,
              ),
              children: [
                TextSpan(
                  text: required == true ? ' *' : '',
                  style: kBR3.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 81,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: kAG2,
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/indonesia_flag.png',
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      '+62',
                      style: TextStyle(color: kAG0),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  autofocus: autofocus ?? false,
                  validator: validator,
                  obscureText: obscureText ?? false,
                  obscuringCharacter: '*',
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    hintText: labelText,
                    labelStyle: kBR3.copyWith(
                      color: kLabel,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: kAG2,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: kAG1,
                        width: 1.2,
                      ),
                    ),
                  ),
                  style: kBR3.copyWith(
                    color: kAG1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Oops!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
