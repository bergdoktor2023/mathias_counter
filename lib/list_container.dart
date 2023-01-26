import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListContainer extends StatelessWidget {
  final int itemIndex;
  final Color containerColor;
  final String groupText;
  final int currentCount;
  final void Function(int) onDecrementClicked;
  final void Function(int) onIncrementClicked;

  const ListContainer({
    super.key,
    required this.itemIndex,
    required this.containerColor,
    required this.groupText,
    required this.currentCount,
    required this.onDecrementClicked,
    required this.onIncrementClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containerColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.remove,
                  ),
                  onPressed: () {
                    HapticFeedback.vibrate();

                    onDecrementClicked.call(currentCount);
                  }),
              Text(
                groupText,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                ),
                onPressed: () {
                  HapticFeedback.vibrate();
                  onIncrementClicked.call(currentCount);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                currentCount.toString(),
              ),
            ],
          ),
          const SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}
