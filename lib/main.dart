import 'package:animated_responsive_layout/destinations.dart';
import 'package:animated_responsive_layout/models/models.dart';
import 'package:animated_responsive_layout/widgets/disappearing_navigation_rail.dart';
import 'package:animated_responsive_layout/widgets/email_list_view.dart';
import 'package:flutter/material.dart';
import './models/data.dart' as data;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: Feed(currentUser: data.user_0)
      );
  }
}


class Feed extends StatefulWidget {
  const Feed( {
    super.key,
    required this.currentUser
  });

  final User currentUser;

  @override 
  State<Feed> createState() => _FeedState();
}


class _FeedState extends State<Feed> {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(_colorScheme.primary.withOpacity(0.14), _colorScheme.surface);

  int selectedIndex = 0;
  bool wideScreen = false;

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Row( 
        children: [ 
          if(wideScreen) 
            DisappearingNavigationRail(backgroundColor: _backgroundColor, selectedIndex: selectedIndex, onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            }),
            Expanded(
              child: Container( 
                color: _backgroundColor,
                child: EmailListView( 
                  currentUser: widget.currentUser,
                  selectedIndex: selectedIndex,
                  onSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
              )
        ],
      ),       
      floatingActionButton: wideScreen 
      ? null 
      : FloatingActionButton( 
        backgroundColor: _colorScheme.tertiaryContainer,
        foregroundColor: _colorScheme.onTertiaryContainer,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: wideScreen 
      ? null
      : NavigationBar( 
        elevation: 0,
        backgroundColor: Colors.white,
        destinations: destinations.map<NavigationDestination>((d) {
          return NavigationDestination(icon: Icon(d.icon), label: d.label);
        } ).toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}