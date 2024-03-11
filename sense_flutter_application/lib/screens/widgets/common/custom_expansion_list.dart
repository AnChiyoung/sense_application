import 'package:flutter/material.dart';

class CustomExpansionList extends StatefulWidget {
  @override
  _CustomExpansionListState createState() => _CustomExpansionListState();
}

class _CustomExpansionListState extends State<CustomExpansionList> {
  List<Item> _data = [
    Item(headerValue: 'Panel 1', expandedValue: 'This is item 1 content', canTapOnHeader: true),
    Item(headerValue: 'Panel 2', expandedValue: 'This is item 2 content', canTapOnHeader: false), // This panel's header is not tappable
    Item(headerValue: 'Panel 3', expandedValue: 'This is item 3 content', canTapOnHeader: true),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            // Only allow panels to expand if canTapOnHeader is true for the selected panel
            if (_data[index].canTapOnHeader) {
              _data[index].isExpanded = !isExpanded;
            }
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              // Customize the header based on canTapOnHeader
              return ListTile(
                title: Text(item.headerValue),
                trailing: item.canTapOnHeader ? null : Container(height: 0, width: 0), // Hide the icon if canTapOnHeader is false
              );
            },
            body: ListTile(
                title: Text(item.expandedValue)
            ),
            isExpanded: item.isExpanded,
            canTapOnHeader: item.canTapOnHeader,
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  Item({required this.headerValue, required this.expandedValue, this.isExpanded = false, this.canTapOnHeader = true});

  String headerValue;
  String expandedValue;
  bool isExpanded;
  bool canTapOnHeader;
}