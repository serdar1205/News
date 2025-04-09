import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController searchCtrl;
  final Function onSearch;
  final Function? onClear;

  const SearchWidget({
    super.key,
    required this.searchCtrl,
    required this.onSearch,
    this.onClear,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool isloading = false;

  Timer? debounce;

  onSearchChange(val) {
    if (debounce?.isActive ?? false) {
      setState(() {});
      debounce?.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 800), fetch);
  }

  fetch() async {
    setState(() {
      isloading = true;
    });
    await widget.onSearch();
    setState(() {
      isloading = false;
    });
  }

  clear() {
    if (widget.onClear != null) {
      widget.onClear!();
    } else {
      widget.searchCtrl.clear();
      widget.onSearch();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: widget.searchCtrl,
      onChanged: onSearchChange,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 6.0, left: 6),
          child: Icon(
            Icons.search,
            color: AppColors.gray,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 24,
          maxWidth: 40,
          minHeight: 24,
          minWidth: 24,
        ),
        errorText: null,
        hintText: "Поиск",
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.gray),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        fillColor: AppColors.formBG,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        suffixIcon: isloading
            ? Container(
                width: 22,
                alignment: Alignment.center,
                child: const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                  ),
                ),
              )
            : widget.searchCtrl.text.isNotEmpty
                ? InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: clear,
                    child: Icon(
                      Icons.clear,
                    ),
                  )
                : null,
      ),
    );
  }
}
