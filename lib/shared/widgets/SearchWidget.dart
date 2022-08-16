
import 'package:billing/modules/search/search_screen.dart';
import 'package:billing/shared/constants/colors.dart';
import 'package:billing/shared/services/LocalString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  __SearchState createState() => __SearchState();
}

class __SearchState extends State<SearchWidget> {
  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                callOpenSearch();
              },
              controller: _editingController,
              // textAlignVertical: TextAlignVertical.center,
            //  onChanged: (_) => callOpenSearch(),
              //onSubmitted: callOpenSearch(),

              //onEditingComplete:  callOpenSearch(),
              decoration: InputDecoration(
                  hintText: LocalString.getStringValue(context, 'search_with') ??
                      "ابحث مع الوفر",
                  hintStyle: TextStyle(color: ColorConstants.hintColor),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon:  IconButton(
                      onPressed: () => setState(
                            () {
                          callOpenSearch();
                        },
                      ),
                      icon: Icon(Icons.search, color: ColorConstants.darkGray))
              ),
            ),
          ),
          _editingController!.text.trim().isEmpty
              ? Text('')
              : IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.clear, color: ColorConstants.darkGray),
            onPressed: () => setState(
                  () {
                _editingController!.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
  callOpenSearch() {
    if(!_editingController!.text.trim().isEmpty)
    {
      Get.to(SearchScreen(Name: _editingController!.text,));
    }
  }
}