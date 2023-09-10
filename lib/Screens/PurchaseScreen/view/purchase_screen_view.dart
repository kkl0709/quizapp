import 'dart:async';

import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  List<ProductDetails> _products = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  /* 구글링 자료 */
  final Stream<List<PurchaseDetails>> purchaseUpdated = InAppPurchase.instance.purchaseStream;

  @override
  void initState() {
    super.initState();
    _initializeProducts();

    final purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      // handle error here.
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // 결제가 성공했을 때의 로직
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
              content: Text(
                '결제 성공',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
          debugPrint('결제 성공');
        }
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            duration: Duration(seconds: 2),
            content: Text(
              '결제 실패',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
        debugPrint('결제 실패');
        // 결제가 실패했을 때의 로직
      }
      // 필요한 경우, 다른 PurchaseStatus들에 대해서도 로직을 추가할 수 있습니다.
    });
  }

  Future<void> _initializeProducts() async {
    final productDetailsResponse =
        await InAppPurchase.instance.queryProductDetails(<String>{'lecture_01'}); // 상품 ID를 여기에 입력하세요.

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
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];

          return ListTile(
            title: Text('Tetra self coaching'),
            subtitle: Text('Lecture'),
            trailing: ElevatedButton(
              child: Text('Buy for ${product.price}'),
              onPressed: () => _purchaseProduct(product),
            ),
          );
        },
      ),
    );
  }
}
