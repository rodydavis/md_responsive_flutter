import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.grey[600]),
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: DashboardHome(),
    );
  }
}

const kTabletBreakpoint = 720.0;
const kDesktopBreakpoint = 1220.0;
const kMaxContentWidth = 1070.0;

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, dimens) => Scaffold(
        drawer: dimens.maxWidth <= kDesktopBreakpoint ? buildDrawer() : null,
        appBar: dimens.maxWidth <= kTabletBreakpoint ? buildAppBar() : null,
        body: Row(
          children: <Widget>[
            if (dimens.maxWidth >= kDesktopBreakpoint) buildDrawer(0),
            Expanded(
                child: Column(
              children: <Widget>[
                if (dimens.maxWidth >= kTabletBreakpoint) buildAppBar(),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: kMaxContentWidth,
                        child: buildBody(dimens.maxWidth),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double width) {
    double elevation = 2;
    if (width >= kMaxContentWidth) {
      width = kMaxContentWidth;
    }
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: 12,
        spacing: 12,
        children: <Widget>[
          Card(
            elevation: elevation,
            child: Container(
              height: 250.0,
            ),
          ),
          Card(
            elevation: elevation,
            child: Container(
              height: 600,
              width: (width * 0.7) - 24,
            ),
          ),
          Card(
            elevation: elevation,
            child: Container(
              height: 300,
              width: (width * 0.3) - 4,
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Home',
        style: TextStyle(color: Colors.grey[600]),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildDrawer([double elevation = 15.0]) {
    return Drawer(
      elevation: elevation,
      child: Container(
        color: Colors.blueGrey.shade700,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('hello@example.com'),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://getmdl.io/templates/dashboard/images/user.jpg')),
                decoration: BoxDecoration(color: Colors.blueGrey.shade900),
                otherAccountsPictures: <Widget>[],
                arrowColor: Colors.white,
              ),
              buildListTile(0, Icons.home, 'Home'),
              buildListTile(1, Icons.inbox, 'Inbox'),
              buildListTile(2, Icons.delete, 'Trash'),
              buildListTile(3, Icons.info, 'Spam'),
              buildListTile(4, Icons.chat, 'Forums'),
              buildListTile(5, Icons.flag, 'Updates'),
              buildListTile(6, Icons.label, 'Promos'),
              buildListTile(7, Icons.shopping_cart, 'Purchases'),
              buildListTile(8, Icons.people, 'Social'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(int index, IconData iconData, String name) {
    final isHovered = index == _hoveredIndex;
    final iconColor =
        isHovered ? Colors.grey.shade600 : Colors.blueGrey.shade300;
    final textColor =
        isHovered ? Colors.grey.shade800 : Colors.blueGrey.shade200;
    return MouseRegion(
      onEnter: (_) => _setHoverIndex(index),
      onExit: (_) => _setHoverIndex(null),
      child: Container(
        color: isHovered ? Color(0xFF4BA1B5) : null,
        child: ListTile(
          leading: Icon(iconData, color: iconColor),
          title: Text(
            name,
            style: TextStyle(color: textColor),
          ),
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
      ),
    );
  }

  void _setHoverIndex(int index) {
    if (mounted)
      setState(() {
        _hoveredIndex = index;
      });
  }
}
