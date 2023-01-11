```
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