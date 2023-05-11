import 'package:flutter/material.dart';

class AddItemView extends StatelessWidget {
  AddItemView({
    Key? key,
    required this.onAdd,
    required this.onClear,
  }) : super(key: key);

  final Function(String) onAdd;
  final Function() onClear;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Enter item',
              hintStyle: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    onAdd(textController.text);
                    textController.clear();
                  }
                },
                child: Text(
                  'Add Item',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              ElevatedButton(
                onPressed: onClear,
                child: Text(
                  'Clear List',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
