part of 'widgets.dart';

class GlobalTextField extends StatefulWidget {
  final EdgeInsets? margin;
  final bool isHintText;
  final String hintText;
  final bool obsecureText;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final bool isPrefix;
  final String prefixText;
  final Color hintTextColor;
  final bool isWordCapitalization;
  final Color inputColor;
  final Color borderColor;
  final Color suffixIconColor;
  final bool isAutofillHints;
  final bool isSuffixIcon;
  final int maxChar;

  GlobalTextField({
    this.isWordCapitalization = false,
    this.hintTextColor = ThemeColor.accentColor4,
    this.margin,
    this.isHintText = false,
    this.hintText = '',
    this.obsecureText = false,
    this.textInputType = TextInputType.text,
    this.controller,
    this.onChange,
    this.isPrefix = false,
    this.prefixText = '',
    this.onSubmitted,
    this.inputColor = ThemeColor.mainColor,
    this.borderColor = ThemeColor.mainColor,
    this.isAutofillHints = false,
    this.isSuffixIcon = false,
    this.suffixIconColor = ThemeColor.mainColor,
    this.maxChar = 100,
  });

  @override
  _GlobalTextFieldState createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool isObsecure = false;

  @override
  void initState() {
    super.initState();
    isObsecure = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.borderColor)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * horizontalMarginHalf,
          ),
          (widget.isPrefix)
              ? Text(
                  widget.prefixText,
                  style: mainFontBlackBold.copyWith(
                      fontSize: 18, color: ThemeColor.mainColor),
                )
              : SizedBox(),
          Flexible(
            child: TextField(
              
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLength: widget.maxChar,
              autofillHints:
                  (widget.isAutofillHints) ? [AutofillHints.email] : null,
              onChanged: widget.onChange,
              onSubmitted: widget.onSubmitted,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              obscureText: isObsecure,
              textCapitalization: (!widget.isWordCapitalization)
                  ? TextCapitalization.none
                  : TextCapitalization.words,
              maxLines: 1,
              style: mainFontBlackBold.copyWith(
                  fontSize: 18, color: widget.inputColor),
              decoration: InputDecoration(
                counterText: '',
                suffixIcon: (widget.isSuffixIcon)
                    ? IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: widget.suffixIconColor,
                          size: 24,
                        ),
                        onPressed: () {
                          if (!isObsecure) {
                            setState(() {
                              isObsecure = true;
                            });
                          } else {
                            setState(() {
                              isObsecure = false;
                            });
                          }
                        },
                      )
                    : null,
                border: InputBorder.none,
                hintStyle: mainFontBlackBold.copyWith(
                  fontSize: 18,
                  color: ThemeColor.accentColor4,
                ),
                hintText: (widget.isHintText) ? '' : widget.hintText,
              ),
              // onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
