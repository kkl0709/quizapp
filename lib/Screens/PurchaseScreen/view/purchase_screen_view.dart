import 'dart:async';
import 'dart:io';

import 'package:chinesequizapp/infrastructure/models/user_model.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

//import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  /* 구글링 자료 */
  final Stream<List<PurchaseDetails>> purchaseUpdated = InAppPurchase.instance.purchaseStream;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  final _inAppPurchase = InAppPurchase.instance;
  List<PurchaseDetails> previousPurchases = [];
  String? _queryProductError = '';
  bool isPurchased = false;

  @override
  void initState() {
    super.initState();

    // 스트림을 열고 구매한 목록만 purchaseDetailsList로 들어옴
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        debugPrint('purchaseDetailsList : ${purchaseDetailsList} ');
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {},
      onError: (error) {
        debugPrint('$error');
      },
    );
    _initStoreInfo();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        Fluttertoast.showToast(msg: '잠시만 기다려 주세요');
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // 여기에 오류가 발생했을 때의 로직을 추가합니다.
          Fluttertoast.showToast(msg: '결제가 실패했습니다.');
          debugPrint('결제 오류');
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          await userExistCheck();
          await FirebaseFirestore.instance
              .collection('user')
              .doc(Utils.userModel.email)
              .update(Utils.userModel.copyWith(isPurchase: true).toJson());
          final newUserDoc =
              await FirebaseFirestore.instance.collection('user').doc(Utils.userModel.email).get();
          Fluttertoast.showToast(msg: '결제가 결제가 성공했습니다. ${purchaseDetails.status}');
          Utils.userModel = UserModel.fromJson(newUserDoc.data()!);
          isPurchased = true;
          debugPrint('결제 완료');
        } else {
          Fluttertoast.showToast(msg: '예외 상황 ${purchaseDetails.status}');
          debugPrint('결제 예외 ${purchaseDetails.status}');
        }
        // 안드로이드는 ios처럼 소비성/비소비성 상품의 구분이 콘솔에서 설정하지 않는다.
        // 이걸 해주어야 유저가 또 구매를 할 수가 있다. 인앱결제 시스템에서 플레이스토어 아이디를 기반으로 저장 한다.
        // 여기 테트라에선 할 필요가 없다.
        /*if (Platform.isAndroid) {
          if (purchaseDetails.productID == 'lecture_01' || purchaseDetails.productID == 'lecture_02') {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }*/
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _initStoreInfo() async {
    //인앱결제를 할 수 있는지 확인
    final productDetailsResponse = await InAppPurchase.instance
        .queryProductDetails(<String>{'lecture_01', 'lecture_02'}); // 상품 ID를 여기에 입력하세요.

    if (productDetailsResponse.notFoundIDs.isNotEmpty) {
      // Handle errors or missing products.
      return;
    }

    setState(() {
      _products = productDetailsResponse.productDetails;
    });
  }

  Future<void> _purchaseProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> userExistCheck() async {
    final userDoc = await FirebaseFirestore.instance.collection('user').doc(Utils.userModel.email).get();
    if (!userDoc.exists) {
      debugPrint('존재하지 않음');
      await FirebaseFirestore.instance.collection('user').doc(Utils.userModel.email).set(UserModel(
            email: Utils.userModel.email,
            isPurchase: false,
            isAdmin: false,
          ).toJson());
      final userDoc = await FirebaseFirestore.instance.collection('user').doc(Utils.userModel.email).get();
      Utils.userModel = UserModel.fromJson(userDoc.data()!);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
                SizedBox(width: 4.0),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                if (_products.isEmpty) {
                  return Container();
                }
                final product = _products[0];

                return ListTile(
                  title: Text('Tetra self coaching'),
                  subtitle: Text('Lecture'),
                  trailing: ElevatedButton(
                    child: Text('강의 구매 하기 ${product.price}'),
                    onPressed: () async {
                      await _purchaseProduct(product);
                      debugPrint('1차 결제 완료');
                      if (!isPurchased) {
                        await _inAppPurchase.restorePurchases();
                        await FirebaseFirestore.instance
                            .collection('purchaseCheck')
                            .doc(DateTime.now().toString())
                            .set({
                          'email': Utils.userModel.email,
                          'product': product.id,
                          'whichPurchase': '다시',
                          'date': Timestamp.now(),
                          'isPurchase': isPurchased,
                        });
                        await Future.delayed(Duration(seconds: 1));
                        if (isPurchased) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        await FirebaseFirestore.instance
                            .collection('purchaseCheck')
                            .doc(DateTime.now().toString())
                            .set({
                          'email': Utils.userModel.email,
                          'product': product.id,
                          'whichPurchase': '한번에',
                          'date': Timestamp.now(),
                          'isPurchase': isPurchased,
                        });
                        await Future.delayed(Duration(seconds: 1));
                        if (isPurchased) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                );
              },
            ),
          ),
          /*ElevatedButton(
            onPressed: () async {
                 */ /*안드로이드 구매내역 확인  */ /*
              if (Platform.isAndroid) {
                InAppPurchaseAndroidPlatformAddition androidAddition =
                    InAppPurchase.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
                QueryPurchaseDetailsResponse response = await androidAddition.queryPastPurchases();
                debugPrint(response.pastPurchases[0].productID.toString());
              }
              final InAppPurchase _inAppPurchase = InAppPurchase.instance;
              final bool available = await _inAppPurchase.isAvailable();
              if (!available) {
                // iOS에서 인앱 구매를 사용할 수 없습니다.
                return;
              }
            },
            child: Text(''),
          ),*/
        ],
      ),
    );
  }
}
