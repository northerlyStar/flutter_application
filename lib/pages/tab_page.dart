export '/pages/tab_page.dart';

import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    final TextEditingController textTestController = TextEditingController();
    textTestController.addListener(() {
      // TODO
      print('text changed.');
    });

    return ListView(
      children: [
        SizedBox(
          height: 180,
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.lightBlue,
                  ),
                  title: Text('三体科技有限公司',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
                  subtitle: Text('地球'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.school,
                    color: Colors.lightBlue,
                  ),
                  title: Text('奎因科技有限公司'),
                  subtitle: Text('地球'),
                ),
              ],
            ),
          ),
        ),
        CardBox(textTestController: textTestController, item: item),
      ],
    );
  }
}

class CardBox extends StatelessWidget {
  const CardBox({
    super.key,
    required this.textTestController,
    required this.item,
  });

  final TextEditingController textTestController;
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
            SimpleDialog(
              title: Center(child: Text('对话框标题')),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('点击第一个')));
                  },
                  child: Text('第一行信息'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('点击第二个')));
                  },
                  child: Text('第二行信息'),
                ),
              ],
            ),
            AlertDialog(
              title: Text('警告！'),
              titlePadding: EdgeInsets.all(15.0),
              content: Column(
                children: [
                  Text('一旦被删除，将无法恢复'),
                  TextField(
                    controller: textTestController,
                    maxLength: 20,
                    maxLines: 1,
                    autofocus: false,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      print('text is change to: $value');
                    },
                    onSubmitted: (value) {
                      print('text is submit, value is: $value');
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      helperText: '用户名',
                      prefixIcon: Icon(Icons.person),
                      suffixText: '用户名',
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.all(12.0),
              actions: [
                TextButton(
                    onPressed: () {
                      print('确定删除');
                    },
                    child: Text('确定')),
                TextButton(
                    onPressed: () {
                      print('取消删除');
                    },
                    child: Text('取消')),
              ],
              actionsPadding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }
}
