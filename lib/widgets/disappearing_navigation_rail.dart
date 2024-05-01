import 'package:animated_responsive_layout/animations.dart';
import 'package:animated_responsive_layout/destinations.dart';
import 'package:animated_responsive_layout/transitions/nav_rail_transition.dart';
import 'package:animated_responsive_layout/widgets/animated_floating_action.button.dart';
import 'package:flutter/material.dart';

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail(
      {super.key,
      required this.railAnimation,
      required this.railFabAnimation,
      required this.backgroundColor,
      required this.selectedIndex,
      this.onDestinationSelected});

  final RailAnimation railAnimation;
  final RailFabAnimation railFabAnimation;
  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return NavRailTransition(
        animation: railAnimation,
        backgroundColor: backgroundColor,
        child: NavigationRail(
            backgroundColor: backgroundColor,
            onDestinationSelected: onDestinationSelected,
            leading: Column(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                const SizedBox(height: 8),
                AnimatedFloatingActionButton(
                  animation: railFabAnimation,
                  elevation: 0,
                    // shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(15))),
                    // backgroundColor: colorScheme.tertiaryContainer,
                    // foregroundColor: colorScheme.onTertiaryContainer,
                    onPressed: () {},
                    child: const Icon(Icons.add))
              ],
            ),
            groupAlignment: -0.85,
            destinations: destinations.map((d) {
              return NavigationRailDestination(
                  icon: Icon(d.icon), label: Text(d.label));
            }).toList(),
            selectedIndex: selectedIndex));
  }
}
