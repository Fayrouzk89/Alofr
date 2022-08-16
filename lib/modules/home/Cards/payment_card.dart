import 'package:billing/models/responses/static_page_response.dart';
import 'package:flutter/material.dart';
import '../../../globals.dart' as globals;
import '../../../shared/services/LocalString.dart';
import '../../buy/buy_controller.dart';
class CreditCardsPage extends StatefulWidget {
  final PaymentMethods? card;
  final BuyController? controller;
  final bool? isBuyAds;
  CreditCardsPage(this.card, this.controller, this.isBuyAds);

  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        if(widget.isBuyAds==true)
          {
            widget.controller!.buyAds(context,widget.card);
          }
        else
        widget.controller!.buyPackage(context,widget.card);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildCreditCard(
            color: Color(0xFF090943),
            cardExpiration: "08/2022",
            cardHolder: "HOUSSEM SELMI",
            cardNumber: "3546 7532 XXXX 9742"
           ,card: widget.card
        ),
      ),
    );
  }

  // Build the title section
  Column _buildTitleSection({@required title, @required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard(
      {required Color color,
        required String cardNumber,
        required String cardHolder,
        required String cardExpiration,
        required PaymentMethods? card
      }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 160,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(card),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                (globals.lang=="ar")?
                card!.paymentMethodAr??"":
                 card!.paymentMethodEn??"",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                   ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: LocalString.getStringValue(context, 'ServiceCharge') ??
                "تكلفة الخدمة",
                  value: card.serviceCharge.toString(),
                ),
                SizedBox(width: 10,),
                _buildDetailsBlock(label:LocalString.getStringValue(context, 'currencyIso') ??
                    "العملة", value: card.currencyIso.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock(PaymentMethods? card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.network(
          card!.imageUrl??"",
          height: 50,
          width: 50,
        )
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Container _buildAddCardButton({
    required Icon icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          print("Add a credit card");
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}