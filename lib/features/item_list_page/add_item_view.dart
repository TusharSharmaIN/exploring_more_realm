import 'package:exploring_more_realm/utils/app_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles/app_colors.dart';

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
          Container(
            decoration: const BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.edit),
                hintText: 'Enter item',
                hintStyle: AppTextStyles.poppinsNormal18.copyWith(
                  color: AppColors.white,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                onAdd(textController.text);
                textController.clear();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  color: AppColors.black,
                ),
                Text(
                  "Add new item",
                  style: AppTextStyles.poppinsNormal18.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
