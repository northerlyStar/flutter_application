export '/pages/tab_page.dart';

import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Tab Bar Test Page',
    //   home: TabBarBox(),
    // );
    return TabBarBox();
  }
}

class ItemView {
  const ItemView({required this.text, required this.icon});
  final String text;
  final IconData icon;
}

const List<ItemView> tabs = [
  ItemView(
    text: '汽车',
    icon: Icons.directions_car,
  ),
  ItemView(
    text: '公共汽车',
    icon: Icons.directions_bus,
  ),
  ItemView(
    text: '自行车',
    icon: Icons.directions_bike,
  ),
  ItemView(
    text: '步行',
    icon: Icons.directions_walk,
  ),
  ItemView(
    text: '轮船',
    icon: Icons.directions_boat,
  ),
];

class TabBarBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tab Bar'),
            bottom: TabBar(
              isScrollable: false,
              tabs: tabs.map((item) {
                return Tab(
                  text: item.text,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
              children: tabs.map((item) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: SelectedItem(item: item),
            );
          }).toList()),
        ));
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({Key? key, required this.item}) : super(key: key);

  final ItemView item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Icon(item.icon, size: 128,), Text(item.text, style: TextStyle(fontSize: 30),)],
        ),
      ),
    );
  }
}
