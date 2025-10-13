import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Terms and conditions",
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
            15.height,
            KText(
              text: "Introduction",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            18.height,
            KText(
              fontSize: 14,
                color: AppColors.greyText,
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n\n  * Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.\n\n  * Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt. \n\n  * Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt. "),
            20.height,
            KText(
              text: "Information we collect",
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            18.height,
            KText(
                fontSize: 14,
                color: AppColors.greyText,
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            20.height,
          ],
        ),
      ),
    );
  }
}
