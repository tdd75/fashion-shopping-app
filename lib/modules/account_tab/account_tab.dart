import 'package:fashion_shopping_app/modules/account_tab/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fashion_shopping_app/core/constants/color.dart';
import 'package:fashion_shopping_app/core/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/core/widgets/icon/base_icon_title.dart';
import 'package:fashion_shopping_app/core/widgets/text/base_text.dart';

class AccountTab extends GetView<AccountController> {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Get.height * .5,
          child: Stack(
            children: [
              Obx(
                () => _buildUserInfo(),
              ),
            ],
          ),
        ),
        _buildListItems(),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const BaseText(
          'Me',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 30,
        ),
        _buildAvatar(),
        const SizedBox(
          height: 10,
        ),
        BaseText(
          controller.user.value?.email ?? '',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: BaseButton(
                text: '100 follower',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BaseButton(
                text: '100 following',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 110,
            width: 110,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: controller.user.value?.avatar ??
                  'https://reqres.in/img/faces/1-image.jpg',
              placeholder: (context, url) => const Image(
                image: AssetImage('assets/images/icon_success.png'),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            width: 110,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstants.primary,
            ),
            child: BaseText(
              controller.user.value?.firstName ?? '',
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItems() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * .42,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // BaseIconTitle(
              //   title: 'Cards',
              //   icon: const Icon(Icons.account_circle),
              //   onTap: () {
              //     Get.toNamed(Routes.layout + Routes.productDetail);
              //   },
              // ),
              // BaseIconTitle(
              //   title: 'Resource',
              //   icon: const Icon(Icons.account_circle),
              //   onTap: () {},
              // ),
              // BaseIconTitle(
              //   title: 'Inbox',
              //   icon: const Icon(Icons.account_circle),
              //   onTap: () {},
              // ),
              const SizedBox(
                height: 8,
              ),
              BaseIconTitle(
                backgroundColor: ColorConstants.lightGray,
                paddingLeft: 16,
                paddingTop: 16,
                paddingRight: 16,
                padingBottom: 16,
                marginRight: 16,
                marginLeft: 5,
                drawablePadding: 10,
                title: 'Logout',
                icon: const Icon(Icons.logout),
                onTap: () => controller.signout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
