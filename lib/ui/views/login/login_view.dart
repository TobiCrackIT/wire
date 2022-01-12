import 'package:eve/eve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moovy/core/constants/app_colors.dart';
import 'package:moovy/core/enums/login_status.dart';
import 'package:moovy/core/utils/alerts.dart';
import 'package:moovy/ui/views/base/base_view.dart';
import 'package:moovy/ui/views/login/login_view_model.dart';
import 'package:moovy/ui/widgets/loader.dart';

class LoginView extends ConsumerWidget {
  LoginView({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, watch) {
    final model = watch(loginNotifier);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (model.loginStatus == LoginStatus.failed) {
        Alerts.showAlert(context, "${model.errorMessage}");
        model.reset();
      }

      if (model.loginStatus == LoginStatus.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderScope(
              overrides: [userProvider.overrideWithValue(model.currentUser!)],
              child: BaseView(),
            ),
          ),
        );
        model.reset();
      }
    });

    //IgnorePointer makes it impossible to modify anything on the screen when a network request is loading
    return IgnorePointer(
      ignoring: model.loginStatus == LoginStatus.loading,
      child: Container(
        //height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.blue,
                title: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EveSpace.verticalSpaceXLarge,
                    EveInputField(
                      title: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      enabled: _emailFocusNode.hasFocus,
                      focusNode: _emailFocusNode,
                      onChanged: (v) => model.setEmailAddress(v),
                      onFieldSubmitted: (_) => _emailFocusNode.unfocus(),
                    ),
                    EveSpace.verticalSpaceXLarge,
                    EveInputField(
                      title: 'Password',
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      enabled: _passwordFocusNode.hasFocus,
                      focusNode: _passwordFocusNode,
                      trailing:model.hidePassword? Icon(Icons.visibility,size: 14,):Icon(Icons.visibility_off,size: 14,),
                      trailingTapped: ()=>model.togglePasswordVisibility(),
                      password: model.hidePassword,
                      onChanged: (v) => model.setPassword(v),
                      onFieldSubmitted: (_) => _passwordFocusNode.unfocus(),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: EveTypography.heading1.copyWith(
                              fontSize: 12,
                              color: AppColors.blue.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(flex: 1, child: Container()),
                    if(model.loginStatus == LoginStatus.loading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Loader(),
                        ],
                      ),
                    if(model.loginStatus != LoginStatus.loading)
                      SizedBox(height: 32,),
                    Expanded(flex: 1, child: Container()),
                    EveButton(
                      title: 'LOGIN',
                      bgColor: AppColors.blue,
                      busy: false,
                      borderRadius: 10,
                      disabled: !model.canContinue,
                      onTap: () => model.login(),
                    ),
                    EveSpace.verticalSpaceLarge,
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
