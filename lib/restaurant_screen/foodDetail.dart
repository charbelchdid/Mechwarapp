
import 'package:c_s_p_app/restaurant_screen/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/images_model.dart';
import '../Models/restaurant_model.dart';
import '../Services/GetImages.dart';
import '../components/map_direction_widget.dart';
import '../review_screen/review_screen_widget.dart';
import 'colors.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'constant.dart';


class FoodDetail extends StatefulWidget {
  final Restaurant Rest;
  FoodDetail(this.Rest);

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  List<Images> images = [];
  List<String> im = [];

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() async {
    images = (await getImages('restaurant', '${widget.Rest.rowGuid}'))!;
    for (int i = 0; i < images.length; i++) {
      im.add(images[i].image);
    }
    setState(() {}); // Update the UI once the images are fetched
  }
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Details'),
    Tab(text: 'Reviews'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
              children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
                physics:BouncingScrollPhysics(),
              children: [
                Container(
                  height:220,
                  child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    physics: NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30,),
                            widget.Rest.openingTime=='NA'?SizedBox():PrimaryText(
                              text: 'Opening Time',
                              color: AppColors.lightGray,
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            widget.Rest.openingTime=='NA'?SizedBox():SizedBox(
                              height: 8,
                            ),
                            widget.Rest.openingTime=='NA'?SizedBox(): PrimaryText(
                              text: widget.Rest.openingTime,
                              fontWeight: FontWeight.w600,
                              size: 16,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            PrimaryText(
                              text: 'Details',
                              color: AppColors.lightGray,
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryText(
                              text: widget.Rest.closingTime, fontWeight: FontWeight.w600,size: 16,),
                          ]),
                    ),
                    Hero(
                      tag: widget.Rest.picture,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 30),],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        height: 200,
                        width: 200,
                        child:
                        CachedNetworkImage( fit: BoxFit.cover, imageUrl: widget.Rest.picture,),
                      ),
                    ),
                  ],
                    scrollDirection: Axis.horizontal,
              ),
                ),
                SizedBox(
                  height: 15,
                ),
                widget.Rest.menu=='NA'?SizedBox(height:0):PrimaryText(
                    text: 'Menu', fontWeight: FontWeight.w700, size: 22),
                widget.Rest.menu=='NA'?SizedBox(height:0):SizedBox(
                  height: 5,
                ),
                widget.Rest.menu=='NA'?SizedBox(height:0):Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      _launchURL("${widget.Rest.menu}");
                    },
                    child: Text(
                      'Click here to open the URL',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                PrimaryText(
                    text: 'Images', fontWeight: FontWeight.w700, size: 22),
                SizedBox(
                  height: 15,
                ),
                buildImageSlider(context),
                SizedBox(
                  height: 15,
                ),
                PrimaryText(
                    text: 'Map', fontWeight: FontWeight.w700, size: 22),
                SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius:  BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    height: 200,
                    //width: displayWidth,
                    child: RouteMapWidget(destinationLatitude: widget.Rest.latitude, destinationLongitude: widget.Rest.longitude, name: widget.Rest.name, type: 'restaurant',),
                  ),
                ),
              ],
          ),
            ),
            ReviewWidget(rowg: widget.Rest.rowGuid, type: 'restaurant',)]), headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {return <Widget>[SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    customAppBar(context),
                    Padding(
                      padding:EdgeInsets.only(left: 20),
                      child: PrimaryText(
                        text: widget.Rest.name,
                        size: 45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20,),
                    TabBar(
                      tabs: myTabs,
                      labelStyle: FlutterFlowTheme.of(context).bodyText1,
                      labelColor: FlutterFlowTheme.of(context).primaryText,
                      indicatorColor: FlutterFlowTheme.of(context).primaryColor,
                    ),
                    SizedBox(height: 20,),
                  ],
                );
              }, childCount: 1),
        ),
        ];  },
        ),
      ),
    );
  }

  Widget buildImageSlider(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: im.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImageScreen(
                    images: im,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(im[index]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding customAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.grey.shade400)),
              child: Icon(Icons.chevron_left),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageScreen({
    required this.images,
    required this.initialIndex,
  });

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: widget.images[index],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, size: 30,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.images.length; i++)
                  buildDotIndicator(i == _currentIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDotIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

void _launchURL(String s) async {
  Uri url = Uri.parse(s); // Replace with your desired URL
  try {
    await launch(url.toString());
  } catch (e) {
    throw 'Could not launch $url';
  }
}