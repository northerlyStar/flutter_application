export '/pages/tab_page.dart';

import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tab Bar'),
          ),
          drawer: DrawerBox(),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            child: Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('you tap FloatingActionButton.')));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.lightBlue,
                      ),
                      title: Text('三体科技有限公司',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      subtitle: Text('地球'),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Colors.lightBlue,
                      ),
                      title: Text('奎因科技有限公司',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                      subtitle: Text('地球'),
                    ),
                  ],
                ),
              ),
              TabBar(
                isScrollable: false,
                tabs: tabs.map((item) {
                  return Tab(
                    text: item.text,
                  );
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                    children: tabs.map((item) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SelectedItem(item: item),
                  );
                }).toList()),
              ),
            ],
          ),
        ));
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

class DrawerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.color_lens),
            ),
            title: Text('个性装扮'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.photo),
            ),
            title: Text('我的相册'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.wifi),
            ),
            title: Text('免流量特权'),
          ),
        ],
      ),
    );
  }
}

enum ConferenceItem { AddMember, LockConference, ModifyLayout, TurnoffAll }

class SelectedItem extends StatelessWidget {
  const SelectedItem({Key? key, required this.item}) : super(key: key);

  final ItemView item;

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        CardBox(item: item),
      ],
    );
  }
}

class CardBox extends StatelessWidget {
  const CardBox({
    super.key,
    required this.item,
  });

  final ItemView item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: PopupMenuButton(
                  icon: Icon(
                    item.icon,
                    size: 128,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            value: ConferenceItem.AddMember,
                            child: Text('添加成员')),
                        PopupMenuItem(
                            value: ConferenceItem.LockConference,
                            child: Text('锁定会议')),
                        PopupMenuItem(
                            value: ConferenceItem.ModifyLayout,
                            child: Text('修改布局')),
                        PopupMenuItem(
                            value: ConferenceItem.TurnoffAll,
                            child: Text('挂断所有')),
                      ]),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('click text button')));
              },
            ),
            TextButton(
              child: Text(
                item.text,
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('click text button')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
