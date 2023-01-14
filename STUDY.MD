```flutter
class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    Key? key,
  }) : super(key: key);

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  @override
  void initState() {
    super.initState();
    print("init");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black,
      ),
    );
  }
}
```

# BuildContext context
* context 는 부모 Widget 에 접근 가능하게 한다.
* `color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black`
    * 해당 코드는 root app 에 정의된 textTheme 에 접근하는 방법

# Life Cycle of Widget
* widget 의 life cycle 에 따라 동작하는 메소드 순서이다
    1. initState() -> 최초에 동작
    2. build() -> widget 을 rendering 시 동작
    3. dispose() -> widget 을 disrendering 시 동작


# Flexible Widget
* UI 비율에 맞게 수정해주는 Widget

# Expanded Widget
* 해당 위젯을 범위를 확장해주는 Widget 

# Center Widget
* 중앙에 위치하게 되는 위젯

# Column 과 Row
* Column 은 열, Row 는 행
* Column
    * MainAxisAlignment : 세로
    * CrossAxisAlignment : 가로
* Row 
    * MainAxisAlignment : 가로
    * CrossAxisAlignment : 세로

# Timer Library
* 타이머 관련 기능 사용 라이브러리
* Timer.periodic(duration, function) : 일정 시간마다 동작하는 타이머

# Column ListView 를 같이 쓰는 경우 . Column and ListView has unlimited height

# Navigator
* 모든 페이지를 스택 자료 구조인 Route Object 로 관리
* Navigator.push : Route 에 다음 페이지 삽입
* Navigator.pop : Route 에서 이전 페이지 추출

```
Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => DetailScreen(
        title: title,
        thumb: thumb,
        id: id,
    ),
    fullscreenDialog: true,
    ),
);
```

# MaterialPageRoute and CupertinoPageRoute

A modal route that replaces the entire screen with a platform-adaptive transition.
The Route class is a high-level abstraction through the navigation feature. However, we will not use it directly, as we have seen that a screen is a route in Flutter. Different platforms may require screen changes to behave differently. In Flutter, there are alternative implementations in a platform-adaptive way. This job is done with MaterialPageRoute and CupertinoPageRoute, which adapt to Android and iOS respectively. So, we must decide when developing an application whether to use the Material Design or iOS Cupertino transitions, or both, depending on the context.

# Hero
A 화면에서 B 화면으로 넘어가는 경우 시작적 효과를 주기 위해 사용한다.
* 같은 이미지를 보여주는 화면인 경우에 사용
* tag 을 지정해 동일 판단함

* example 
Main -> DetailScreen 으로 넘어가는 예제
Hero 에 Tag 을 지정한다.

```
import 'package:flutter/material.dart';

void main() => runApp(HeroApp());

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            'https://picsum.photos/250?image=9',
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen();
          }));
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=9',
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

```

# shadow
Shadow 효과를 주기 위해서는 painting library 를 사용해야 함.
```
Container(
    width: 250,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(10, 10),
                color: Colors.black.withOpacity(0.5),
            ),
        ],
    ),
    child: Image.network(thumb),
),
```

# FutureBuild
비동기 요청으로 데이터를 전송받고, 이미지를 렌더링해야 되는 경우 사용
```
FutureBuilder(
    future: episodes,
    builder: (context, snapshot) {
        if (snapshot.hasData) {
        return Container(
            child: Column(
            children: [
                for (var episode in snapshot.data!)
                Episode(
                    episode: episode,
                    webtoonId: widget.id,
                )
            ],
            ),
        );
        } else {
        return const CircularProgressIndicator();
        }
    },
),
```

# GestureDetector
제스처 감지를 지원하지 않는 위젯을 감싸서, 특정 제스쳐의 동작을 Catch 하여 원하는 Action 을 할 수 있도록 지원
```
    return GestureDetector(
      onTap: onButtonTap, // 여러 제스쳐 중 onTap 인 경우 onButtonTap method 실행
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.green[700],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                ),
              ),
            ],
          ),
        ),
      ),
    );

```

# launchUrl
문자, 전화, 웹사이트등 url 을 통해서 다양한 앱의 위젯을 열도록 도와주는 라이브러리

# shared_preferences 
* App 의 로컬 스토리지를 사용하는 방법
* SharedPrefences.getInstance method 를 통해서 App Cache? Storage 를 가져올 수 있음
* getInstance method 의 return value 는 Future 을 반환함.

```
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }
```