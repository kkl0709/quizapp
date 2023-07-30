import 'dart:convert';
import 'dart:io';
import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart' as account;
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthType {
  undefined(-1),
  email(0),
  kakao(1),
  naver(2),
  google(3),
  apple(4),
  facebook(5);

  const AuthType(this.code);

  factory AuthType.fromCode(int? code) =>
      AuthType.values.firstWhere((element) => element.code == code,
          orElse: () => AuthType.undefined);

  final int code;
}

class AuthenticationHelper {
  static AccountRepository _repository = AccountRepository();
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      "email",
      // "https://www.googleapis.com/auth/userinfo.profile",
      // "https://www.googleapis.com/auth/user.birthday.read",
      // "https://www.googleapis.com/auth/user.gender.read",
      // "https://www.googleapis.com/auth/contacts"
    ],
  );

  static void login(AuthType type) {
    switch (type) {
      case AuthType.kakao:
        loginKakao();
        break;
      case AuthType.naver:
        loginNaver();
        break;
      case AuthType.apple:
        loginApple();
        break;
      case AuthType.google:
        loginGoogle();
        break;
      case AuthType.facebook:
        loginFacebook();
        break;
    }
  }

  static Future<void> _createAccount(
      account.Account account, AuthType type) async {
    DatabaseResp dbResp = await _repository.validateAccount(
      account.email ?? '',
    );

    if (dbResp.isException == false) {
      if (account.email != null) {
        await _repository.createAccount(account);
      }
    } else {
      DatabaseResp validResp = await _repository
          .validateAccountByAuth(account.email ?? '', authType: type);

      if (validResp.isException == true) {
        Fluttertoast.showToast(
            msg: '이미 존재하는 이메일입니다.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.transparent,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    }
    await SharedPreferenceService.saveLoggedIn(true, account.email!, type.code);
    Fluttertoast.showToast(
        msg: '로그인 되었습니다.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);
    Get.toNamed(RoutesConstants.homeScreen);
  }

  static void loginKakao() async {
    bool checksAccount = false;
    OAuthToken? token;

    // await UserApi.instance.logout(); //=> 로그아웃
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        final url = Uri.https('kapi.kakao.com', '/v2/user/me');
        final response = await http.get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token!.accessToken}',
          },
        );

        Map<String, dynamic> json = jsonDecode(response.body);
        String email = json["kakao_account"]["email"];

        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        await SharedPreferenceService.saveLoggedIn(
            true, email, AuthType.kakao.code);
        Get.toNamed(RoutesConstants.homeScreen);
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
          SharedPreferenceService.saveLogout();
          await UserApi.instance.logout();
          return;
        }

        try {
          // 토큰 바꼈을 경우
          if (await isKakaoTalkInstalled()) {
            token = await UserApi.instance.loginWithKakaoTalk();
          } else {
            token = await UserApi.instance.loginWithKakaoAccount();
          }
          print('로그인 성공 ${token.accessToken}');
          final url = Uri.https('kapi.kakao.com', '/v2/user/me');
          final response = await http.get(
            url,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
            },
          );

          Map<String, dynamic> json = jsonDecode(response.body);
          String email = json["kakao_account"]["email"];
          AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

          _repository.resetPassword(email, tokenInfo.toString(),
              authType: AuthType.kakao.code);
        } catch (error) {
          print('로그인 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        if (await isKakaoTalkInstalled()) {
          try {
            token = await UserApi.instance.loginWithKakaoTalk();
            print('isKakaoTalkInstalled - 카카오톡으로 로그인 성공 / $token');
            checksAccount = true;
          } catch (error) {
            print('isKakaoTalkInstalled - 카카오톡으로 로그인 실패 $error');
            if (error is PlatformException && error.code == 'CANCELED') {
              return;
            }
            // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
            try {
              token = await UserApi.instance.loginWithKakaoAccount();
              print('카카오계정으로 로그인 성공 / $token');
              checksAccount = true;
            } catch (error) {
              print('카카오계정으로 로그인 실패 $error');
            }
          }
        } else {
          try {
            token = await UserApi.instance.loginWithKakaoAccount();
            print('미설치 카카오계정으로 로그인 성공 / $token');
            checksAccount = true;
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      } catch (error) {
        print('로그인 실패 $error');
      }
      if (checksAccount) {
        final url = Uri.https('kapi.kakao.com', '/v2/user/me');
        final response = await http.get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token?.accessToken}',
          },
        );

        Map<String, dynamic> json = jsonDecode(response.body);
        String email = json["kakao_account"]["email"];
        String nickname = json["properties"]["nickname"];
        int birthDay = int.parse(json["kakao_account"]["birthday"]);
        int gender = json["kakao_account"]["gender"] == "male" ? 0 : 1;
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

        _createAccount(
            account.Account(
                authType: AuthType.kakao.code,
                email: email,
                name: nickname,
                password: tokenInfo.id.toString(),
                birthday: birthDay,
                gender: gender,
                createdAt: DateTime.now()),
            AuthType.kakao);
      }
    }

//
  }

  static void loginNaver() async {
    final currentAccessToken = await FlutterNaverLogin.currentAccessToken;

    if (!currentAccessToken.accessToken.isEmpty) {
      /// 로그인 정보 있을 경우
      NaverAccountResult naverAccount =
          await FlutterNaverLogin.currentAccount();
      SharedPreferenceService.saveLoggedIn(
          true, naverAccount.email, AuthType.naver.code);
      Get.toNamed(RoutesConstants.homeScreen);
    } else {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccountResult naverAccount = result.account;
      final int birthday = int.parse(
          '${naverAccount.birthyear}${naverAccount.birthday.replaceAll('-', '')}');

      account.Account newAccount = account.Account(
        authType: AuthType.naver.code,
        email: naverAccount.email,
        password: naverAccount.id,
        name: naverAccount.nickname,
        birthday: birthday,
        gender: naverAccount.gender == "M" ? 0 : 1,
        createdAt: DateTime.now(),
      );
      _createAccount(newAccount, AuthType.naver);
    }
  }

  static void loginFacebook() async {
    /* implementation */
  }

  static void loginApple() async {
    final String clientID = ApiConstants.authAppleClientKey;
    final String redirectURL =
        "https://quizapp-5eba7.firebaseapp.com/__/auth/handler";

    final AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: clientID,
        redirectUri: Uri.parse(redirectURL),
      ),
    );
    // final oauthCredential = OAuthProvider("apple.com").credential(
    //   idToken: credential.identityToken,
    //   accessToken: credential.authorizationCode,
    // );
    // UserCredential _authResult =
    //     await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    final account.Account newAccount = account.Account(
        authType: AuthType.google.code,
        email: credential.email,
        name: '${credential.givenName} ${credential.familyName}',
        password: credential.userIdentifier,
        createdAt: DateTime.now());

    _createAccount(newAccount, AuthType.apple);
  }

  static void loginGoogle() async {
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    final account.Account newAccount = account.Account(
        authType: AuthType.google.code,
        email: googleAccount?.email,
        name: googleAccount?.displayName,
        password: googleAccount?.id,
        createdAt: DateTime.now());

    _createAccount(newAccount, AuthType.google);
  }

  static Future<void> logout(AuthType type) async {
    switch (type) {
      case AuthType.kakao:
        await UserApi.instance.logout();
        break;
      case AuthType.naver:
        // await FlutterNaverLogin.logOut();
        break;
      case AuthType.apple:
        await FirebaseAuth.instance.signOut();
        break;
      case AuthType.google:
        _googleSignIn.signOut();
        break;
    }
  }

  static unregister(AuthType type) async {
    switch (type) {
      case AuthType.kakao:
        await UserApi.instance.unlink();
        break;
      case AuthType.apple:
        await FirebaseAuth.instance.signOut();
        break;
      case AuthType.naver:
        // await FlutterNaverLogin.logOutAndDeleteToken();
        break;
      case AuthType.google:
        await _googleSignIn.disconnect();
        break;
    }
  }
}
