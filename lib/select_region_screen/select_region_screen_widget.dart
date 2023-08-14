import 'package:c_s_p_app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Models/regions_model.dart';
import '../Services/Regions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
import 'select_region_screen_model.dart';
export 'select_region_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectRegionScreenWidget extends StatefulWidget {
  const SelectRegionScreenWidget({Key? key}) : super(key: key);

  @override
  _SelectRegionScreenWidgetState createState() =>
      _SelectRegionScreenWidgetState();
}

class _SelectRegionScreenWidgetState extends State<SelectRegionScreenWidget> {
  late SelectRegionScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  late Regions _RegionsList=Regions(success: false, data: []);
  late List<Datum> _filteredList=[];

  void _getData() async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    _RegionsList = provider.Region;
    _RegionsList.data.sort((a, b) => a.name.compareTo(b.name));
    _filteredList=_RegionsList.data;
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectRegionScreenModel());
    _getData();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Where do you want to go?',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child:ListView(
          physics: BouncingScrollPhysics(),
          //mainAxisSize: MainAxisSize.max,
          children: [
            getSearchBarUI(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: _RegionsList.data==[]?CircularProgressIndicator():SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _filteredList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)=>
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                          child: GestureDetector(
                            onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBarPage(rowguid: '${_filteredList[index].rowGuid}', startingPage: 4,)));},
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: '${_filteredList[index].image}',
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                        child: Text(
                                          '${_filteredList[index].name} - ${_filteredList[index].arabicName}',
                                          style:FlutterFlowTheme.of(context).subtitle1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            ),
          ],
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
                        _filteredList=_RegionsList.data.where((restaurant) => restaurant.name
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
