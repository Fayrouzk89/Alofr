import 'package:flutter/material.dart';

import '../../../../models/responses/categories_response.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/utils/size_config.dart';
import '../../Cards/category_card.dart';

class CategoryPage extends StatelessWidget {

   final List<Category> data;
   CategoryPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TwoCardPageView(data: data);
  }
}

class TwoCardPageView extends StatefulWidget {
  final List<Category> data;
   TwoCardPageView({Key? key, required this.data}) : super(key: key);

  @override
  TwoCardPageViewState createState() => TwoCardPageViewState();
}

class TwoCardPageViewState extends State<TwoCardPageView> {

  final PageController _pageController =
  PageController(viewportFraction: 0.92, initialPage: 0);
  double _page = 0;
  int count=5;
  int countPages=100;
   List<Category> _items=[];
  @override
  void initState() {
    super.initState();
    final List<Category> items = widget.data;
    _items=items;
    countPages= _items!.length ~/ count;
    if((_items!.length % count)>0)
    {
      countPages =countPages+1;
    }
    setState(() {

    });
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _page = _pageController.page!;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_items!=null)?Container(
      child: Column(
        children: [
          Container(
            // color: Colors.red,
            //  width: SizeConfig().screenWidth,
            height: SizeConfig().screenWidth*ColorConstants.categoryWidth+40,
            child: PageView.builder(
                controller: _pageController,
                itemCount: countPages,
                itemBuilder: (context, index) {
                  return SizedBox(

                    child: Row(
                      children: [
                        ItemBuilder(items: _items, index: index * count),
                        Container(
                            child: index * count + 1 >= _items.length
                                ? const SizedBox()
                                : ItemBuilder(
                                items: _items, index: index * count + 1)),
                        Container(
                            child: index * count + 2 >= _items.length
                                ? const SizedBox()
                                : ItemBuilder(
                                items: _items, index: index * count + 2)),
                        Container(
                            child: index * count + 3 >= _items.length
                                ? const SizedBox()
                                : ItemBuilder(
                                items: _items, index: index * count + 3)),
                        Container(
                            child: index * count + 4 >= _items.length
                                ? const SizedBox()
                                : ItemBuilder(
                                items: _items, index: index * count + 4)),
                      ],
                    ),
                  );
                }),
          ),
          (countPages>1)?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < countPages; i++)
                Container(
                  margin: const EdgeInsets.only(left: 3,right: 3),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.5),
                      color: _page - i > 1 || _page - i < -1
                          ? Colors.transparent
                          : _page - i > 0
                          ? Colors.grey.withOpacity(1 - (_page - i))
                          : Colors.grey.withOpacity(1 - (i - _page))),
                )
            ],
          ):Text('')
        ],
      ),
    ):Text("");
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required List<Category> items,
    required this.index,
  })  : _items = items,
        super(key: key);

  final List<Category> _items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      width:SizeConfig().screenWidth*ColorConstants.categoryWidth,
      height: SizeConfig().screenWidth*ColorConstants.categoryWidth+100,
      //color: _items[index].color,
      child: Container(
          child:  CategoryCard(
            category:  _items[index],
          )
        /*
          Text(
            _items[index].name,
            style: const TextStyle(fontSize: 25),
          )

               */
      ),
    );
  }
}
