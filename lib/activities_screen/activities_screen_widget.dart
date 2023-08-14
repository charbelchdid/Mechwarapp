import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../map_screen/map_screen_widget.dart';
import '../provider/LoadProvider.dart';
import '../trip_details_screen/trip_details_screen_widget.dart';
import '../userprofile_screen/userprofile_screen_widget.dart';
import 'activities_screen_model.dart';
export 'activities_screen_model.dart';

class ActivitiesScreenWidget extends StatefulWidget {
  ActivitiesScreenWidget({Key? key}) : super(key: key);
  @override
  _ActivitiesScreenWidgetState createState() => _ActivitiesScreenWidgetState();
}

class _ActivitiesScreenWidgetState extends State<ActivitiesScreenWidget> with TickerProviderStateMixin{
  late ActivitiesScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _model = createModel(context, () => ActivitiesScreenModel());
  }

  // @override
  // void dispose() {
  //   _model.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: true);
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x430F1113),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'What\'s For Today?',
                        style: FlutterFlowTheme.of(context).title3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.ActivityList.length,
                  itemBuilder: (BuildContext context, int index,) {
                    final int count =
                    provider.ActivityList.length > 10 ? 10 : provider.ActivityList.length;
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
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TripDetailsScreenWidget(tripdetail: provider.ActivityList[index],)));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: CachedNetworkImageProvider(
                                      provider.ActivityList[index].picture,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${provider.ActivityList[index].title}',
                                              style:
                                              FlutterFlowTheme.of(context).title2,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TripDetailsScreenWidget(tripdetail: provider.ActivityList[index],)));
                                                },
                                                text:provider.ActivityList[index].isReserved==false?'Details':'Reserved',
                                                icon: provider.ActivityList[index].isReserved==false?Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 15,
                                                ):Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 120,
                                                  height: 40,
                                                  color:FlutterFlowTheme.of(context).primaryColor,
                                                  textStyle: GoogleFonts.getFont(
                                                    'Lexend Deca',
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                  elevation: 3,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );});}
              ),
            ),
          ],
        ),
      );
  }
}
