import 'dart:async';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';

class AutocompleteBasicExample extends StatefulWidget {
  final TextEditingController? searchController;

  const AutocompleteBasicExample({Key? key, this.searchController}) : super(key: key);

  @override
  State<AutocompleteBasicExample> createState() => _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  List<String> _searchItems = [];
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) => _searchItems.where(
        (String option) => option.contains(
          textEditingValue.text.toLowerCase(),
        ),
      ),
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
            if (timer == null || (timer?.isActive ?? false)) {
              timer = Timer(const Duration(seconds: 2), () {
                _searchItems = <String>[
                  'aardvark',
                  'bobcat',
                  'chameleon',
                ];
              });
            } else {
              timer?.cancel();
            }
          },
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration().searchTxtFieldStyle(maxHeight: 50),
        );
      },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected,
          Iterable<String> options) {
        return Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return ListTile(
                      onTap: () => onSelected(option),
                      // leading: Image.asset(
                      //   AppAssets.searchIcon,
                      //   width: 16,
                      //   height: 16,
                      //   fit: BoxFit.contain,
                      // ),
                      title: Text(
                        option,
                        style: const TextStyle().bold.copyWith(color: Colors.black),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: medGreyColor,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 1,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
