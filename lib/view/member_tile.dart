import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberTile extends ConsumerWidget {
  const MemberTile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(6),
      color: Colors.deepOrangeAccent.shade100.withOpacity(0.5),
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: 100,
            child: Text('groupInf'),
          ),
          Container(
            width: 100,
            height: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade200),
                // side: MaterialStateProperty.all<BorderSide>(
                //   BorderSide(
                //     color: Colors.red, //色
                //     width: 1, //太さ
                //   ),
                // ),
              ),
              onPressed: () {},
              child: Text("１回"),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 100,
            height: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade200),
              ),
              onPressed: () {},
              child: Text("１回"),
            ),
          )
        ],
      ),
    );
  }
}
