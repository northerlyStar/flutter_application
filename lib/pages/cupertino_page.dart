export '/pages/cupertino_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPage extends StatefulWidget {
  @override
  State<CupertinoPage> createState() => _CupertinoPageState();
}

class _CupertinoPageState extends State<CupertinoPage> {
  final List<String> tabs = ['Home'];

  int currentIndex = 0;

  void changeCurrentIndex(int value) {
    setState(() {
      currentIndex = value;
      print('currentIndex: $currentIndex');
    });
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Person',
        ),
      ]),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return HomePage();
              case 1:
                return ChatPage(onPressed: (int value) => changeCurrentIndex(value));
              case 2:
                return PersonPage(onPressed: (int value) => changeCurrentIndex(value));
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}

class PersonPage extends StatelessWidget {
  final Function(int) onPressed; // 接收回调函数

  const PersonPage({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Person'),
        leading: IconButton(
            onPressed: () => onPressed(0),
            icon: Icon(CupertinoIcons.back)),
      ),
      child: CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(child: Text('Yes')),
          CupertinoDialogAction(child: Text('No')),
        ],
        title: Text('Warning!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Are you sure?'),
              Text('Data deletion cannot be recovered!'),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final Function(int) onPressed; // 接收回调函数

  const ChatPage({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Chat'),
          leading: IconButton(
            onPressed: () => onPressed(0),
            icon: Icon(CupertinoIcons.back),
          ),
          trailing: Icon(CupertinoIcons.add),
        ),
        child: Center(
          child: CupertinoButton(
              color: Colors.blue,
              child: Text(
                'Button',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print('you click button.');
              }),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Home'),
        ),
        child: Center(
            child: CupertinoActivityIndicator(
          radius: 60.0,
        )));
  }
}
