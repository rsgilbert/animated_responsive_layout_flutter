import 'package:animated_responsive_layout/animations.dart';
import 'package:animated_responsive_layout/destinations.dart';
import 'package:animated_responsive_layout/models/models.dart';
import 'package:animated_responsive_layout/transitions/list_detail_transition.dart';
import 'package:animated_responsive_layout/widgets/animated_floating_action.button.dart';
import 'package:animated_responsive_layout/widgets/disappearing_bottom_navigation_bar.dart';
import 'package:animated_responsive_layout/widgets/disappearing_navigation_rail.dart';
import 'package:animated_responsive_layout/widgets/email_list_view.dart';
import 'package:animated_responsive_layout/widgets/reply_list_view.dart';
import 'package:flutter/material.dart';
import './models/data.dart' as data;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        home: Feed(currentUser: data.user_0));
  }
}

class Feed extends StatefulWidget {
  const Feed({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
      _colorScheme.primary.withOpacity(0.14), _colorScheme.surface);
  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: 0,
      vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  bool controllerInitialized = false;
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.of(context).size.width;

    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      // width is less than 600
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Scaffold(
            body: Row(
              children: [
                DisappearingNavigationRail(
                    railAnimation: _railAnimation,
                    railFabAnimation: _railFabAnimation,
                    backgroundColor: _backgroundColor,
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }),
                Expanded(
                  child: Container(
                      color: _backgroundColor,
                      child: ListDetailTransition(
                        animation: _railAnimation,
                        one: EmailListView(
                          currentUser: widget.currentUser,
                          selectedIndex: selectedIndex,
                          onSelected: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                        two: const ReplyListView(),
                      )),
                )
              ],
            ),
            floatingActionButton: AnimatedFloatingActionButton(
              animation: _barAnimation,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: DisappearingBottomNavigationBar(
              barAnimation: _barAnimation,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            )));
  }
}
