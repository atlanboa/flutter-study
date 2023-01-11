import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;

  final Color _white = Colors.white;
  final Color _black = const Color(0xFF1F2123);
  final int order;
  final List<Offset> offsets = [
    const Offset(0, 0),
    const Offset(0, 0),
    const Offset(0, -20),
    const Offset(0, -40)
  ];

  CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offsets[order],
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: isInverted ? _white : _black,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? _black : _white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? _black : _white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: isInverted ? _black : _white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(-5, 20),
                child: Transform.scale(
                  scale: 2.2,
                  child: Icon(
                    icon,
                    color: isInverted ? _black : _white,
                    size: 70,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
