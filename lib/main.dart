import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '/pages/user.dart';
import '/pages/tab_page.dart';

void main() {
  FlutterError.onError = (details) {
    debugPrint("Caught Flutter error: ${details.exception}");
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: true,
        routes: {
          '/': (context) => MyHomePage(),
          '/tabPage': (context) => TabPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}

// App 状态
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  int count = 0;

  void getNext() {
    current = WordPair.random();
    count++;
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite({WordPair? pair}) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(item) {
    favorites.remove(item);
    notifyListeners();
  }
}

// 主页
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        // page = Placeholder();
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainPage = ColoredBox(
      color: colorScheme.surfaceContainer,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, container) {
          if (container.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainPage),
                SafeArea(
                  top: false,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    currentIndex: selectedIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorite',
                      ),
                    ]
                  )
                ),
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: container.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: mainPage,
                ),
              ],
            );
          }
        } 
      )
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取app状态
    var appState = context.watch<MyAppState>();
    // 当前显示的词组
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, '/tabPage');
          }, child: Text('test route'))
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          child: Text(pair.asLowerCase, style: style, semanticsLabel: '${pair.first} ${pair.second}',),
        ),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myAppState = context.watch<MyAppState>();
    var favoriteList = myAppState.favorites;

    if (favoriteList.isEmpty) {
      return Center(
        child: Text('No Favorites yet.'),
      );
    }

    return ListView.builder(
      itemCount: favoriteList.length,
      itemBuilder: (context, index) => ListTile(
        leading: IconButton(icon: Icon(Icons.favorite), onPressed: () {
          myAppState.removeFavorite(favoriteList[index]);
        },),
        title: Text(favoriteList[index].toString())
      ),
    );
  }
}
