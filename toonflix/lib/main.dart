import 'package:flutter/material.dart';

void main() {
  // var nico = Player(name: 'nico');
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<int> numbers = [];
  bool showTitle = true;

  void onClicked() {
    setState(() {
      numbers.add(numbers.length);
    });
  }

  void toggle() {
    setState(() {
      showTitle = showTitle ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.red,
        ),
      )),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('nothing'),
              IconButton(
                onPressed: toggle,
                icon: const Icon(Icons.check_box),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
// class App extends StatelessWidget {
//   Player player;

//   App(this.player);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 80,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Hey, Selena",
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(1),
//                           fontSize: 30,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       Text(
//                         "Welcome Back",
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.8),
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 80,
//               ),
//               Text(
//                 'Total Balance',
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 '\$599,999',
//                 style: TextStyle(
//                   fontSize: 42,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white.withOpacity(1),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SingleChildScrollView(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Button(
//                       text: "Transfer",
//                       bgColor: Colors.amber,
//                       textColor: Colors.black,
//                     ),
//                     Button(
//                       text: "Request",
//                       bgColor: Color(0xFF1F2123),
//                       textColor: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 80,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Wallets',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 35,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'View All',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.8),
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CurrencyCard(
//                 name: "Euro",
//                 code: "EUR",
//                 amount: "6 428",
//                 icon: Icons.euro_rounded,
//                 isInverted: false,
//                 order: 1,
//               ),
//               CurrencyCard(
//                 name: "Dollar",
//                 code: "BTC",
//                 amount: "55 622",
//                 icon: Icons.currency_bitcoin,
//                 isInverted: true,
//                 order: 2,
//               ),
//               CurrencyCard(
//                 name: "Dollar",
//                 code: "USD",
//                 amount: "428",
//                 icon: Icons.attach_money,
//                 isInverted: false,
//                 order: 3,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Player {
//   String name = 'nico';

//   Player({required this.name});
// }
