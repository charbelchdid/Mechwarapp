import 'package:c_s_p_app/provider/LoadProvider.dart';
import 'package:c_s_p_app/restaurant_screen/home.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'Services/Connection.dart';
import 'Services/GetUserRowg.dart';

import 'Services/NotificationService.dart';
import 'discover_screen/discover_screen_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';

import 'home_screen/home_screen_widget.dart';
import 'hotel_screen/hotel_home_screen.dart';
import 'index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_ripple/flutter_ripple.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterFlowTheme.initialize();
  NotificationService().setupFirebaseMessaging();
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoadProvider(),
        ),
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (_) => ConnectivityProvider(),
        ),
      ],
      child:  Builder(
        builder: (context) {
          Provider.of<ConnectivityProvider>(context, listen: false).initConnectivity();
          return MaterialApp(
            home: ConnectivityHandler(

              child: MyApp(),
            ),
          );
        },
      ),
      )
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;



  bool displaySplashImage = true;
  @override
  void initState() {
    super.initState();
    }



  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mechwar',
      localizationsDelegates: [
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light, textSelectionTheme: TextSelectionThemeData(selectionHandleColor: FlutterFlowTheme.of(context).primaryColor),),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),

     );
  }
}

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    List<Future> s = [
      provider.checkLocationPermission(context),
      checkEmailFromLocalDatabase(context),
      provider.getRegionList(),
    provider.getMarker(context),
      provider.getUserInfo(0,context),
    ];
    return FutureBuilder(
      future: Future.wait(s),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SelectRegionScreenWidget();
        }
        else {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/newlogo.png",),
                fit:BoxFit.cover,
              )
            ),
          );
        }
      },
    );
  }
}
class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page,required this.rowguid,required this.startingPage}) : super(key: key);
  final int startingPage;
  final String? initialPage;
  final Widget? page;
  final String rowguid;
  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'ActivitiesScreen';
  late List<Widget> screens = []; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen = screens[widget.startingPage]; // Our first view in viewport

  late int currentTab;
  void _onTabSelected(int index) {
    setState(() {
      currentTab  = index;
    });
  }
  @override
  void initState() {
    super.initState();
    currentTab  = widget.startingPage;
    _currentPageName = widget.initialPage ?? _currentPageName;
    screens=[
      ActivitiesScreenWidget(),
      RestaurantNew(),
      //RestaurantsScreenWidget(RegionRowguid: widget.rowguid,),
      //PlaceScreenWidget(Regionrowguid: widget.rowguid,),
      HotelHomeScreen(),
      UserprofileScreenWidget(),
      List13PropertyListviewWidget(Regionrowguid: widget.rowguid,)
    ];
    final provider = Provider.of<LoadProvider>(context, listen: false);
    provider.getActivity(widget.rowguid,provider.state==0?'c1b63fcf-b58e-4996-9679-48c9d38b6eef':provider.userRowguid);
    provider.getPlacesList(widget.rowguid);
    provider.getRestaurants(widget.rowguid);
    provider.getHotel(widget.rowguid);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: true);
    final String options = 'assets/icons/options.svg';
    const IconData globe = IconData(0xf68d, );
    return provider.PlacesList.length!=0 && provider.ActivityList.length!=0? provider.ActivityList[0].region!=widget.rowguid?Scaffold(body: Center(child: FlutterRipple(
        rippleColor:FlutterFlowTheme.of(context).primaryColor, child: Text("Flutter Ripple"),
    ),)):Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Mechwar',
          style: FlutterFlowTheme.of(context).title1
        //       .override(
        //     fontFamily: 'Lexend Deca',
        //     fontSize: 25,
        // //    fontWeight: FontWeight.normal,
        //   ),
        ),
        actions: [
          IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreenWidget(rowg: widget.rowguid)));}, icon:Icon(Icons.map,color: Colors.grey,size: 30,),),
          IconButton(onPressed: (){ Navigator.pop(context);}, icon:Icon(Icons.place,color: Colors.grey,size: 30,),),
          SizedBox(width: 10,)
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body:  PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTabSelected(4);
          currentScreen=screens[currentTab];
        },
        child: Icon(Icons.explore),
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color:FlutterFlowTheme.of(context).secondaryBackground ,
        height: 70,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.event_available,
                    color: currentTab == 0 ? FlutterFlowTheme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(0);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==0? Text('Events',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.restaurant,
                    color: currentTab == 1 ? FlutterFlowTheme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(1);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==1? Text('Restaurants',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
            SizedBox(width: 48.0), // Empty space for the FAB
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.hotel,
                    color: currentTab== 2 ? FlutterFlowTheme.of(context).primaryColor: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(2);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==2? Text('Hotels',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: currentTab == 3 ? FlutterFlowTheme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(3);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==3? Text('Profile',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
          ],
        ),
      ),
    ):Scaffold(body: Center(child: FlutterRipple(
      rippleColor:FlutterFlowTheme.of(context).primaryColor, child: Text(""),
    ),));
  }
}
