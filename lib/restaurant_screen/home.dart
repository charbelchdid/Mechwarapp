import 'package:c_s_p_app/flutter_flow/flutter_flow_theme.dart';
import 'package:c_s_p_app/restaurant_screen/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Models/restaurant_model.dart';
import '../provider/LoadProvider.dart';
import 'colors.dart';
import 'constant.dart';
import 'foodDetail.dart';

class RestaurantNew extends StatefulWidget {
  @override
  _RestaurantNewState createState() => _RestaurantNewState();
}
// bakry bar coff rst snck swt
class _RestaurantNewState extends State<RestaurantNew> with TickerProviderStateMixin{
  int selectedFoodCard = 0;
  late List<Restaurant> _RestaurantList=[];
  late List<Restaurant> _showList=[];
  late List<Restaurant> _filtList=[];
  AnimationController? animationController;
  void initState() {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    _RestaurantList=provider.RestaurantsList;
    for(int i=0;i<_RestaurantList.length;i++){
      if(_RestaurantList[i].type=='restaurant'){
        _showList.add(_RestaurantList[i]);
      }
    }
    _filtList=_showList;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }
  void changeList(int index){
    _showList=[];
    if(index==0){
      for(int i=0;i<_RestaurantList.length;i++){
        if(_RestaurantList[i].type=='restaurant'){
          _showList.add(_RestaurantList[i]);
        }
      }
    }
    else if(index==1){
      for(int i=0;i<_RestaurantList.length;i++){
        if(_RestaurantList[i].type=='snack'){
          _showList.add(_RestaurantList[i]);
        }
      }
    }
    else if(index==2){
      for(int i=0;i<_RestaurantList.length;i++){
        if(_RestaurantList[i].type=='coffeeshop'){
          _showList.add(_RestaurantList[i]);
        }
      }
    }
    else if(index==3){
      for(int i=0;i<_RestaurantList.length;i++){
        if(_RestaurantList[i].type=='sweet'){
          _showList.add(_RestaurantList[i]);
        }
      }
    }
    else if(index==4){
      for(int i=0;i<_RestaurantList.length;i++){
        if(_RestaurantList[i].type=='bar'){
          _showList.add(_RestaurantList[i]);
        }
      }
    }
    else if(index==5){
      for(int i=0;i<_RestaurantList.length;i++){
        if(_RestaurantList[i].type=='pat'){
          _showList.add(_RestaurantList[i]);
        }
      }
    }
    _filtList=_showList;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              physics: BouncingScrollPhysics(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics:BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _filtList.length,
                        itemBuilder: (BuildContext context, int index) {
                        final int count =
                        _filtList.length > 10 ? 10 : _filtList.length;
                        final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController!,
                                curve: Interval(
                                    (1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                        animationController?.forward();
                        return AnimatedBuilder(animation: animation, builder: (BuildContext context, Widget? child)
                        {return FadeTransition(
                          opacity: animationController!,
                          child: Transform(
                            transform: Matrix4.translationValues(
                                0.0, 50 * (1.0 - animation!.value), 0.0),
                            child: popularFoodCard(
                                _filtList[index]),
                          ),
                        );
                        }
                        );
                      },
                      ),
                  ),
                ],
              ), headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        getSearchBarUI(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: PrimaryText(
                                  text: 'Categories',
                                  fontWeight: FontWeight.w700,
                                  size: 22),
                            ),
                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: foodCategoryList.length,
                                itemBuilder: (context, index){
                                  return Padding(
                                    padding: EdgeInsets.only(left: index == 0 ? 25 : 0),
                                    child: foodCategoryCard(
                                        foodCategoryList[index]['imagePath']!,
                                        foodCategoryList[index]['name']!,
                                        index),
                                  );
                                },
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                    );
                  }, childCount: 1),
            ),
              ]; },
            ),
          ),
        ],
      ),
    );
  }
  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {
                      setState(() {
                        _filtList=_showList.where((rest) => rest.name
                            .toLowerCase()
                            .contains(txt.toLowerCase()))
                            .toList();
                      });
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: FlutterFlowTheme.of(context).primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: FlutterFlowTheme.of(context).primaryBackground),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget popularFoodCard(Restaurant Rest) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FoodDetail(Rest)))
      },
      child: Container(
        margin: EdgeInsets.only(right: 25, left: 20, top: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.lighterGray)],
          color: AppColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2.2,
                        child: PrimaryText(
                            text: Rest.name, size: 22, fontWeight: FontWeight.w700),
                      ),
                      Rest.openingTime=='NA'?SizedBox():PrimaryText(
                          text:Rest.openingTime, size: 18, color: AppColors.lightGray),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Row(
                        children: [
                          Icon(Icons.add, size: 20),
                          Text('Details')
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 12),
                          SizedBox(width: 5),
                          PrimaryText(
                            text: Rest.rating,
                            size: 18,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 100,
              height: 100,
              transform: Matrix4.translationValues(30.0, 25.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade400, blurRadius: 20)
                  ]),
              child: Hero(
                tag: Rest.picture,
                child: CircleAvatar(backgroundColor: FlutterFlowTheme.of(context).primaryColor,backgroundImage: CachedNetworkImageProvider( Rest.picture)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget foodCategoryCard(String imagePath, String name, int index) {
    return GestureDetector(
      onTap: () => {
        setState(
          () => {
            print(index),
            selectedFoodCard = index,
            changeList(selectedFoodCard)
          },
        ),
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                selectedFoodCard == index ?FlutterFlowTheme.of(context).primaryColor : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.lighterGray,
                blurRadius: 15,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(imagePath, width:55),
            PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
          ],
        ),
      ),
    );
  }
}
