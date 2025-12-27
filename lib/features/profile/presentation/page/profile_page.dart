import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/features/profile/presentation/page/policy_page.dart';
import 'package:booking/features/profile/presentation/page/setting_page.dart';
import 'package:booking/features/profile/presentation/page/terms_conditions_page.dart';
import 'package:booking/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../notifications/presentation/widget/notifications_button_widget.dart';
import '../widget/profile_header_card_widget.dart';
import '../widget/tile_widget.dart';
import 'about_page.dart';
import 'contact_us_page.dart';
import 'edit_profile_page.dart';
import 'favorite_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primarySwatch.shade100.withValues(alpha: .7),
                  AppColors.primarySwatch.shade50.withValues(alpha: .4),
                  AppColors.scaffoldColor,
                  AppColors.scaffoldColor,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SvgPicture.asset(
              AppIcons.topPattern,
              height: 200.h,
              color: Colors.black54,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.h,
              children: [
                14.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: AutoSizeTextWidget(
                        text: S.of(context).profile,
                        fontSize: 15.sp,
                      ),
                    ),
                    const NotificationsButtonWidget(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.h,
                    children: [
                      ProfileHeaderCardWidget(onLogoutSuccess: _refresh),
                      Visibility(
                        visible: Auth().loggedIn,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12.h,
                          children: [
                            TileWidget(
                              icon: AppIcons.profile,
                              title: S.of(context).personalInfo,
                              context: context,
                              onTap: () {
                                navigateTo(context,
                                    EditProfilePage(onSuccess: _refresh));
                              },
                            ),
                            TileWidget(
                              icon: AppIcons.favorite,
                              title: S.of(context).favorites,
                              context: context,
                              onTap: () {
                                navigateTo(context, const FavoritePage());
                              },
                            ),
                          ],
                        ),
                      ),
                      TileWidget(
                        icon: AppIcons.setting,
                        title: S.of(context).generalSettings,
                        context: context,
                        onTap: () {
                          navigateTo(
                              context, SettingsPage(onSuccess: _refresh));
                        },
                      ),
                      TileWidget(
                        icon: AppIcons.infoCircle,
                        title: S.of(context).aboutApp,
                        context: context,
                        onTap: () {
                          navigateTo(context, const AboutPage());
                        },
                      ),
                      TileWidget(
                        icon: AppIcons.phone,
                        title: S.of(context).contactUs,
                        context: context,
                        onTap: () {
                          navigateTo(context, const ContactUsPage());
                        },
                      ),
                      TileWidget(
                        icon: AppIcons.messageQuestion,
                        title: S.of(context).privacyPolicyTitle,
                        context: context,
                        onTap: () {
                          navigateTo(context, const PolicyPage());
                        },
                      ),
                      TileWidget(
                        icon: AppIcons.messageQuestion,
                        title: S.of(context).termsTitle,
                        context: context,
                        onTap: () {
                            navigateTo(context, const TermsConditionsPage());
                        },
                      ),
                    ],
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
