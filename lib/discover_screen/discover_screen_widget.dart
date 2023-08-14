import 'package:cached_network_image/cached_network_image.dart';

import '../Models/region_places_models.dart';
import '../provider/LoadProvider.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'list13_property_listview_model.dart';
export 'list13_property_listview_model.dart';

class List13PropertyListviewWidget extends StatefulWidget {
  const List13PropertyListviewWidget({Key? key,required this.Regionrowguid}) : super(key: key);
  final String Regionrowguid;
  @override
  _List13PropertyListviewWidgetState createState() =>
      _List13PropertyListviewWidgetState();
}

class _List13PropertyListviewWidgetState
    extends State<List13PropertyListviewWidget> with TickerProviderStateMixin {
  late List13PropertyListviewModel _model;
  late List<Place> _placeList=[];
  late List<Place> _filteredList=[];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LoadProvider>(context, listen: false);
    _model = createModel(context, () => List13PropertyListviewModel());

    _model.textController ??= TextEditingController();
    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    _placeList=provider.PlacesList;
    _filteredList=_placeList;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: true);
    if(provider.PlacesList.length!=0&&_filteredList.length==_placeList.length){
      setState(() {
        _placeList=provider.PlacesList;
        _filteredList=_placeList;
      });
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    controller: _model.tabBarController,
                    children: [
                      NestedScrollView(
                        physics: BouncingScrollPhysics(),
                        body: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _filteredList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final int count =
                            _filteredList.length > 10 ? 10 : _filteredList.length;
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
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(16, 8, 16, 12),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child: CachedNetworkImage(

                                              width: double.infinity,
                                              height: 230,
                                              fit: BoxFit.cover, imageUrl: _filteredList[index].picture,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(16, 0, 16, 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                _filteredList[index].name,
                                                style: FlutterFlowTheme.of(context).subtitle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );});
                          },
                        ), headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    getSearchBarUI(),
                                    Align(
                                      alignment: Alignment(0, 0),
                                      child: TabBar(
                                        labelColor: FlutterFlowTheme.of(context).primaryText,
                                        unselectedLabelColor:
                                        FlutterFlowTheme.of(context).secondaryText,
                                        labelStyle: FlutterFlowTheme.of(context).subtitle1,
                                        unselectedLabelStyle: TextStyle(),
                                        indicatorColor: FlutterFlowTheme.of(context).primaryColor,
                                        tabs: [
                                          Tab(
                                            text: 'Homes',
                                            icon: Icon(
                                              Icons.home_filled,
                                            ),
                                          ),
                                          Tab(
                                            text: 'Beachfront',
                                            icon: Icon(
                                              Icons.beach_access_rounded,
                                            ),
                                          ),
                                          Tab(
                                            text: 'Nature',
                                            icon: Icon(
                                              Icons.nature_people,
                                            ),
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (value) => setState(() {}),
                                      ),
                                    ),
                                  ],
                                );
                              }, childCount: 1),
                        ),
                        ]; },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                        _filteredList=_placeList.where((place) => place.name
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
}
