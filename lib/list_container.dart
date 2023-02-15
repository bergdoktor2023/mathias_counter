import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListContainer extends StatelessWidget {
  final Color containerColor;
  final String groupText;
  final int currentCount;
  final void Function(int) onDecrementClicked;
  final void Function(int) onIncrementClicked;
  final void Function(String, int)? onEditNumberClicked;

  const ListContainer({
    super.key,
    required this.containerColor,
    required this.groupText,
    required this.currentCount,
    required this.onDecrementClicked,
    required this.onIncrementClicked,
    this.onEditNumberClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      color: containerColor,

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 25),
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
    ),
              onPressed: () {
                HapticFeedback.vibrate();

                onDecrementClicked.call(currentCount);
              }),
          SizedBox(width: 20),


                   Expanded(

            child: Padding(

              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(

                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        textStyle:


                        Theme.of(context).textTheme.headlineSmall,



                      ),
                      child: Text(groupText,
                          style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white),
                      ),

                      onPressed: (){
                        onEditNumberClicked?.call(groupText, currentCount);}
                  ),

                  Text(
                      currentCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                ],
                ),

              ),
              ),



          IconButton(
            color: Colors.transparent,
            icon: const Icon(
              Icons.edit,

            ),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              HapticFeedback.vibrate();
              onIncrementClicked.call(currentCount);

            },

          ),
          SizedBox(width: 25),
        ],
      ),
    );
  }
}
