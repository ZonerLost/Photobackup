import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/login_page.dart';
import 'package:photobackup/view/drawer/profile_setting.dart';
import 'package:photobackup/view/drawer/privacy_policy.dart';
import 'package:photobackup/view/drawer/terms_and_conditions.dart';
import 'package:photobackup/widgets/drawer_widgets/drawer_dialogues.dart';

import '../../controller/auth_controller.dart';

Widget getDrawer(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
        color: AppColors.whiteColor,
        border: Border(
          right: BorderSide(
            color: AppColors.primaryColor,
            width: 10,
          ),
        )),
    width: 300,
    child: Drawer(
      backgroundColor: Colors.transparent,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Builder(
            builder: (context) {
              return Container(
                height: 120,
                alignment: Alignment.centerLeft,
                child: showSvgIconWidget(
                  iconPath: AppIcons.menuIcon,
                  width: 36,
                  height: 36,
                  onTap: () => Scaffold.of(context).closeDrawer(),
                ),
              );
            },
          ),
          Space.vertical(5),
          customListTile(
              title: "Profile Setting",
              bgColor: AppColors.pastelPink,
              iconPath: AppIcons.profileIcon,
              onTap: () => Get.to(() =>  ProfileSetting())),
          Space.vertical(2),
          customListTile(
              title: "Terms & Conditions",
              bgColor: AppColors.skyMist,
              iconPath: AppIcons.policiesIcon,
              onTap: () => Get.to(() => const TermsAndConditions())),
          Space.vertical(2),
          customListTile(
              title: "Privacy Policy",
              bgColor: AppColors.iceMint,
              iconPath: AppIcons.fileIcon,
              onTap: () => Get.to(() => const PrivacyPolicy())),
          Space.vertical(2),
          customListTile(
              title: "Delete Account",
              bgColor: AppColors.pastelPink,
              iconPath: AppIcons.deleteIcon,
              onTap: () => DrawerDialogues.confirmationDialog(
                  context: context,
                  iconPath: AppIcons.deletedIcon,
                  title: "Delete Account",
                  content: "Are you sure you want to delete your account?",
                  confirmText: "Delete",
                  cancelText: "Cancel",
                  textColor: AppColors.whiteColor,
                  btnColor: AppColors.redColor,
                  showBorderColor: true,
                  onConfirm: () {
                    final controller = Get.find<AuthController>();
                    controller.handleDeleteUserAccount();
                  })),
          Space.vertical(13),
          customListTile(
            title: "Logout",
            bgColor: AppColors.skyMist,
            iconPath: AppIcons.logoutIcon,
            onTap: () => DrawerDialogues.confirmationDialog(
              context: context,
              iconPath: AppIcons.logoutAccount,
              title: "Logout",
              content: "Are you sure you want to logout your account?",
              confirmText: "Logout",
              cancelText: "Cancel",
              textColor: AppColors.whiteColor,
              btnColor: AppColors.primaryColor,
              showBorderColor: true,
              onConfirm: () {
                final controller = Get.find<AuthController>();
                controller.logoutUser();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customListTile({
  String? title,
  Color? bgColor,
  String? iconPath,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: showSvgIconWidget(
              iconPath: iconPath!,
              width: 20,
              height: 20,
            ),
          ),
          Space.horizontal(1.6),
          Expanded(
            child: KText(
              text: title ?? "",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
