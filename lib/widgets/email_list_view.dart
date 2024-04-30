import 'package:animated_responsive_layout/models/models.dart';
import 'package:flutter/material.dart';
import '../models/data.dart' as data;

class EmailListView extends StatelessWidget {
  const EmailListView(
      {super.key,
      this.selectedIndex,
      this.onSelected,
      required this.currentUser});

  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8), 
        child: ListView(
          children: [
            const SizedBox(height: 8),
            search_bar.SearchBar(currentUser:currentUser),
            const SizedBox(height: 8),
            ...List.generate(data.emails.length, 
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8), 
              child: EmailWidget( 
                email: data.emails[index],
                onSelected: onSelected == null 
                ? null 
                : (){
                  onSelected!(index);
                }
              ,
              isSelected : selectedIndex == index
              )
            );
            }
            )
          ],
        ));
  }
}
