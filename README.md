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

# Navigator.push
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

# MaterialPageRoute


# Hero