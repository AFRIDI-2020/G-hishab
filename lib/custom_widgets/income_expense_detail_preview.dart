import 'package:flutter/material.dart';


class IncomeExpenseDetailPreview extends StatelessWidget {
  String date;
  String description;
  String amount;
  IncomeExpenseDetailPreview({Key? key, required this.date, required this.description, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            vertical: size.width * .03,
            horizontal: size.width * .03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * .035),
              ),
            ),
            Expanded(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * .035),
              ),
            ),
            Expanded(
              child: Text(
                '$amount টাকা',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * .035),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
