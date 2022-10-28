import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';

class TypeChoice extends StatelessWidget {
  TypeChoice({super.key});

  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Obx((() => IconButton(
              icon: SvgPicture.asset(
                'assets/images/down-arrow.svg',
                color: c.typeChoice.value == 1
                    ? const Color.fromARGB(255, 33, 150, 243)
                    : Colors.white,
                // width: 1,
              ),
              onPressed: (() => c.typeChoice.value = 1),
              color: Colors.black,
              splashRadius: 1,
            )))
          ),
          Expanded(
            child: Obx((() => IconButton(
              icon: SvgPicture.asset(
                'assets/images/up-arrow.svg',
                color: c.typeChoice.value == 2
                    ? const Color.fromARGB(255, 179, 3, 0)
                    : Colors.white,
                // width: 1,
              ),
              onPressed: (() => c.typeChoice.value = 2),
              color: Colors.black,
              splashRadius: 1,
            )))
          ),
        ],
      ),
    );
  }
}
