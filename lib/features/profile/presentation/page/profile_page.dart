import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/features/profile/presentation/page/setting_page.dart';
import 'package:booking/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/go_to_login_widget.dart';
import '../../../../generated/l10n.dart';
import '../widget/section_profile_widget.dart';
import '../widget/tile_widget.dart';
import 'about_page.dart';
import 'contact_us_page.dart';
import 'edit_profile_page.dart';
import 'faq_page.dart';
import 'favorite_page.dart';


class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return Visibility(
      visible: Auth().loggedIn,
      replacement: GoToLoginWidget(),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeTextWidget(
            text:  S.of(context).profileTitle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.primaryColor,
                        child:  SvgPicture.asset(
                            AppIcons.profile,
                          color: Colors.white,
                          height: 18.h,
                          width: 18.w,
                        ),
                        //  backgroundImage: AssetImage('assets/images/profile.jpg'),
                      ),
                      SizedBox(width: 12.w),
                      AutoSizeTextWidget(
                        text: Auth().name,
                        fontSize: 13.sp,
                        colorText: const Color(0xff001A33),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SectionProfileWidget(children: [
                  TileWidget(
                    icon: AppIcons.profile,
                    title:  S.of(context).personalInfo,
                    context: context,
                    onTap: () {
                      navigateTo(context, const EditProfilePage());

                    },
                  ),
                  TileWidget(
                    icon: AppIcons.favorite,
                    title:  S.of(context).favorites,
                    context: context,
                    onTap: () {
                      navigateTo(context, const FavoritePage());


                    },
                  ),
                  TileWidget(
                    icon: AppIcons.setting,
                    title:  S.of(context).generalSettings,
                    context: context,
                    onTap: () {
                      navigateTo(context, const SettingsPage());
                    },
                  ),
                ]),
                SizedBox(height: 12.h),
                SectionProfileWidget(
                  children: [
                    TileWidget(
                      icon: AppIcons.infoCircle,
                      title:  S.of(context).aboutApp,
                      context: context,
                      onTap: () {
                        navigateTo(context, const AboutPage());
                      },
                    ),
                    TileWidget(
                      icon: AppIcons.phone,
                      title:  S.of(context).contactUs,
                      context: context,
                      onTap: () {
                        navigateTo(context, const ContactUsPage());
                      },
                    ),
                    TileWidget(
                      icon: AppIcons.messageQuestion,

                      title:  S.of(context).faq,
                      context: context,
                      onTap: () {
                        navigateTo(context, const FAQPage());
                      },
                    ),
                    TileWidget(
                      icon: AppIcons.sharing,
                      title:  S.of(context).shareApp,
                      context: context,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
