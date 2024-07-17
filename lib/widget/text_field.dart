import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '/utils/widget_extensions.dart';
import '../data/cache/palette.dart';
import 'apptexts.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final String? hint;
  final String? labelText;
  final bool readonly;
  final bool borderless;
  final bool isDark;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? errorWidget;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? label;
  final Widget? prefix;
  final double? textSize;
  final double? borderRadius;
  final Color? hintColor;
  final Color? bodyTextColor;
  final Color? fillColor;
  final Color? textColor;
  final bool? enabled;
  final bool? overrideIconColor;
  final VoidCallback? onTap;
  final AutovalidateMode? autoValidateMode;
  final InputBorder? enabledBorder;
  final int? maxLength;
  final int? maxHeight;
  final bool? haveText;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const AppTextField(
      {Key? key,
        this.readonly = false,
        this.borderless = false,
        this.isPassword = false,
        this.hintText,
        this.hint,
        this.onChanged,
        this.controller,
        this.keyboardType = TextInputType.text,
        this.onTap,
        this.onEditingComplete,
        this.onFieldSubmitted,
        this.validator,
        this.autofillHints,
        this.suffixIcon,
        this.textSize,
        this.haveText,
        this.maxLength,
        this.labelText,
        this.label,
        this.contentPadding,
        this.prefix, this.maxHeight = 1, this.hintColor, this.textColor, this.inputFormatters, this.errorWidget, this.enabled, this.fillColor, this.overrideIconColor, this.enabledBorder, this.autoValidateMode, required this.isDark, this.borderRadius, this.bodyTextColor, this.textInputAction})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hintText != null
              ? Column(
            children: [
              AppText(
                widget.hintText ?? "",
                size: widget.textSize ?? 13.5.sp,
                color :widget.hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
                // isBold: true,
                align: TextAlign.start,
                weight: FontWeight.w500,
              ),
              5.0.sbH,
            ],
          )
              : 0.0.sbH,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  validator: widget.validator,
                  autofillHints: widget.autofillHints,
                  onEditingComplete: widget.onEditingComplete,
                  autovalidateMode: widget.autoValidateMode,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  maxLines: widget.maxHeight,
                  focusNode: _focusNode,
                  maxLength: widget.maxLength,
                  onChanged: (val) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(val);
                    }
                  },
                  onTap: widget.onTap,
                  readOnly: widget.readonly,
                  enabled: widget.enabled,
                  obscureText: widget.isPassword ? !isVisible : false,
                  textInputAction: widget.textInputAction?? TextInputAction.next,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Satoshi', color: widget.bodyTextColor),
                  controller: widget.controller,
                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    filled: true, // Add this line to enable filled decoration
                    errorMaxLines: 3,
                    counter: 0.0.sbH,
                    hintText: widget.hint,
                    enabled: widget.enabled??true,
                    fillColor:widget.enabled == false? Theme.of(context).secondaryHeaderColor.withOpacity(0.13): ( widget.fillColor?? Colors.transparent),
                    error: widget.errorWidget,
                    prefixIconColor: widget.overrideIconColor ==true? null: const Color(0xFF2A2A2A),
                    suffixIconColor: widget.overrideIconColor ==true? null: const Color(0xFF2A2A2A),
                    prefixIcon: widget.prefix==null? null : SizedBox(height: 40.sp, width: 40.sp ,child: Align(alignment: Alignment.center, child: widget.prefix)),
                    suffixIcon: widget.suffixIcon ?? (widget.isPassword
                        ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: widget.suffixIcon ??
                            Icon(isVisible
                                ? Iconsax.eye_slash
                                : Iconsax.eye, size: 20,
                              color: Theme.of(context).unselectedWidgetColor,
                            ))
                        : widget.suffixIcon),

                    label: widget.label,
                    labelText: widget.labelText,
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: widget.textColor?? (widget.isDark? Colors.white.withOpacity(0.5): const Color(0xFFC5C0BF)),fontSize: 15.sp, fontFamily: 'Satoshi'),
                    helperStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Satoshi'),
                    isDense: true,
                    contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
                    focusedBorder: OutlineInputBorder(borderSide:
                    BorderSide(color: widget.borderless? Colors.transparent:  primaryColor, width: 3.sp),
                        borderRadius: BorderRadius.circular(widget.borderRadius??8.sp)),
                    enabledBorder: widget.enabledBorder?? OutlineInputBorder(
                        borderSide: BorderSide(width: 0.8.sp, color: widget.borderless?Colors.transparent:(widget.isDark? Colors.white.withOpacity(0.9) : const Color(0xFF2A2A2A).withOpacity(0.6))),
                        borderRadius: BorderRadius.circular(widget.borderRadius??8.sp)),
                    errorBorder:OutlineInputBorder(
                        borderSide: BorderSide(width: 2.sp, color: widget.borderless?Colors.transparent: widget.isDark? Theme.of(context).colorScheme.error:  errorColor),
                        borderRadius: BorderRadius.circular(widget.borderRadius??8.sp)),
                    errorStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: widget.isDark? Theme.of(context).colorScheme.error:  errorColor),
                    focusedErrorBorder:OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: widget.borderless?Colors.transparent:  primaryColor,),
                        borderRadius: BorderRadius.circular(widget.borderRadius??8.sp)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.8.sp, color: Theme.of(context).secondaryHeaderColor.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(widget.borderRadius??8.sp)),
                  ),
                  keyboardType: widget.keyboardType,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



class CustomPhoneNumberInput extends StatelessWidget {
  final Function? onSubmit;
  final double? textSize;
  final double? borderWidth;
  final double? radius;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final Function(PhoneNumber)? onSaved;
  final Function(PhoneNumber)? onInputChanged;
  final String? isoCode;
  final String? hint;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final TextEditingController? controller;
  const CustomPhoneNumberInput({
    super.key,
    this.onSubmit,
    this.onSaved,
    this.isoCode,
    this.onInputChanged,
    this.controller,
    this.hint = "Phone Number",
    this.textSize,
    this.hintColor,
    this.validator,
    this.enabled = true,
    this.borderWidth,
    this.radius,
    this.contentPadding,
    this.labelText, this.hintText
  });

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hintText != null
            ? Column(
          children: [
            AppText(
              hintText ?? "",
              size: textSize ?? 13.5.sp,
              color : hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
              // isBold: true,
              align: TextAlign.start,
              weight: FontWeight.w500,
            ),
            5.0.sbH,
          ],
        ) : 0.0.sbH,
        Column(
          children: [
            InternationalPhoneNumberInput(
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Satoshi'),
              onInputChanged: (PhoneNumber number) => onInputChanged!(number),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              initialValue: PhoneNumber(
                isoCode: 'NG', // Set the default country using its ISO code (e.g., 'US' for United States)
              ),
              isEnabled: enabled,
              inputBorder: OutlineInputBorder(borderSide:
              BorderSide(color:primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(8)),
              searchBoxDecoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor:enabled? Colors.transparent: Colors.grey.withOpacity(0.5),
                focusedBorder: OutlineInputBorder(borderSide:
                BorderSide(color:primaryColor, width: 3),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.8, color: Theme.of(context).cardColor == Colors.black? Colors.white.withOpacity(0.9) : const Color(0xFF2A2A2A).withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(8)),
                errorBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: errorColor),
                    borderRadius: BorderRadius.circular(8)),
                errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                focusedErrorBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color :primaryColor,),
                    borderRadius: BorderRadius.circular(8)),
                disabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 0.8, color: const Color(0xFF2A2A2A).withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(8)),
              ),
              inputDecoration: InputDecoration(
                isDense: true,
                // border: InputBorder.none,
                hintText: hint!,
                filled: true,
                fillColor:enabled? Colors.transparent: Colors.grey.withOpacity(0.3),
                focusedBorder: OutlineInputBorder(borderSide:
                BorderSide(color:primaryColor, width: 3),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.8, color: Theme.of(context).cardColor == Colors.black? Colors.white.withOpacity(0.9) : const Color(0xFF2A2A2A).withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(8)),
                errorBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error),
                    borderRadius: BorderRadius.circular(8)),
                errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                focusedErrorBorder:OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color :primaryColor,),
                    borderRadius: BorderRadius.circular(8)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.8, color: const Color(0xFF2A2A2A).withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8)),
              ),
              textFieldController: controller,
              // initialValue: PhoneNumber(isoCode: isoCode!),
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: true,
              selectorTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Satoshi'),
              autoValidateMode: AutovalidateMode.disabled,
              onSaved: (PhoneNumber number) => {onSaved!(number)},
              onSubmit: () => onSubmit!(),
              validator: validator,
            ),
          ],
        ),
      ],
    );
  }
}

class NewDropDownSelect extends StatelessWidget {
  final String? hintText;
  final String? hint;
  final double? height;
  final double? textSize;
  final Color? hintColor;
  final Widget? prefix;
  final String? value;
  final List<String>? items;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String? value)? onChanged;
  const NewDropDownSelect({Key? key,
    this.hintText,
    this.hint,
    this.value,
    this.items,
    this.onChanged, this.validator, this.inputFormatters, this.height, this.textSize, this.hintColor, this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hintText != null
            ? Column(
          children: [
            AppText(
              hintText ?? "",
              size: textSize ?? 13.5.sp,
              color :hintColor ?? Theme.of(context).textTheme.bodyMedium?.color,
              // isBold: true,
              align: TextAlign.start,
              weight: FontWeight.w500,
            ),
            5.0.sbH,
          ],
        )
            : 0.0.sbH,
        Container(
          alignment: Alignment.centerLeft,
          child: DropdownButtonFormField(
            borderRadius: BorderRadius.circular(12),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Aileron'),
            icon: const Icon(Icons.keyboard_arrow_down),
            value: value,
            items: items
                ?.map((e) => DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Aileron'),
                    ),
                  ),
                ],
              ),
            ))
                .toList(),
            onChanged: onChanged,
            isExpanded: true,
            dropdownColor: Theme.of(context).backgroundColor,
            validator: validator,
            decoration: InputDecoration(
              errorMaxLines: 3,
              border: InputBorder.none,
              isDense: true,
              hintText: hint,
              prefix: prefix,
              hintStyle: TextStyle(color: Theme.of(context).disabledColor),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding:EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.8, color: Theme.of(context).cardColor == Colors.black? Colors.white.withOpacity(0.9) : const Color(0xFF2A2A2A).withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(8)),
              errorBorder:OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: errorColor),
                  borderRadius: BorderRadius.circular(8)),
              errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              focusedErrorBorder:OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color :primaryColor,),
                  borderRadius: BorderRadius.circular(8)),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.transparent, width: 0.8),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        )
      ],
    );
  }
}

class TextArea extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final TextAlign? textAlign;
  final TextInputType? keyBoardType;
  final String? Function(String? val)? validationCallback;
  final void Function()? onEdittingComplete;
  final String? formError;
  final String label;
  final String? hintText;
  final FocusNode? focusnode;
  final TextEditingController? controller;
  final String? message;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Function()? clearForm;
  final Function()? onTap;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool? enabled;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool? show;
  final Color? fillColor;
  final Color? hintColor;
  final bool? showCursor;
  final bool readOnly;
  final Widget? labelRightItem;
  final TextStyle? labelStyle;
  final int? minLines;
  final int? maxLines;

  const TextArea({super.key,
    this.autovalidateMode,
    this.inputFormatters,
    this.textAlign,
    this.keyBoardType,
    this.onEdittingComplete,
    this.validationCallback,
    this.message,
    this.hintText,
    this.label="",
    this.formError,
    this.focusnode,
    this.controller,
    this.clearForm,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.enabled = true,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.fillColor,
    this.hintColor,
    this.showCursor,
    this.readOnly = false,
    this.labelRightItem,
    this.labelStyle, this.show,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        label.isEmpty || label==""?0.0.sbH:AppText(
          label,
          size: 14,
          align: TextAlign.start,
        ),
        label.isEmpty || label==""?0.0.sbH:8.0.sbH,
        TextField(
          showCursor: showCursor,
          readOnly: readOnly,
          maxLength: 1000,
          enabled: enabled,
          onTap: onTap,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, fontFamily: 'Aileron'),
          minLines: minLines,
          maxLines: 5,
          focusNode: focusnode,
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: show==null?Theme.of(context).dividerColor.withOpacity(0.07):Colors.transparent,
            counterText: '',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, color: hintColor),
            isDense: true,
            hintText: hintText,
            errorText: formError,
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: primaryColor, width: 0.8),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: Theme.of(context).disabledColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:  Colors.deepOrange, width: 0.8),
                borderRadius: BorderRadius.circular(8)),
            errorStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
          ),
          textAlign: textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters,
          keyboardType: keyBoardType,
          onChanged: onChanged,
          onEditingComplete: onEdittingComplete,
          obscureText: obscureText ?? false,
        ),
      ],
    );
  }
}