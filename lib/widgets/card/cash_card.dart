import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/src/helper/date.dart';
import 'package:moneybook/src/helper/string.dart';

import 'package:flutter/material.dart';
import 'package:moneybook/widgets/text/text_with_icon.dart';

class CardCash extends ConsumerStatefulWidget {
  const CardCash({Key? key, required this.cash}) : super(key: key);

  final Cash cash;

  @override
  _CardCash createState() => _CardCash();
}

class _CardCash extends ConsumerState<CardCash> {
  String addCurrency(int price) {
    return ref.read(currencyProvider.notifier).joinCurrency(price);
  }

  void editCash() {
    final id = widget.cash.id;
    final date = widget.cash.date;
    Navigator.of(context).pushNamed(
      '/cash/edit',
      arguments: {'id': id, 'date': date},
    );
  }

  Color getTextColor(DateTime date) {
    if (isSaturDay(date: date)) {
      return Colors.blue[700]!;
    } else if (isSunday(date: date)) {
      return Colors.red[700]!;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final diffDateFromPrev = widget.cash.diffDateFromPrev;
    final date = widget.cash.date;
    final textColor = getTextColor(date);
    final category =
        ref.read(categoryProvider.notifier).findByLabel(widget.cash.category);
    final fillColor = category.color;
    final icon = category.icon;
    final hasMember = widget.cash.member.isNotEmpty;

    return Column(
      children: [
        if (diffDateFromPrev)
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateToString(date: date, weekDay: true),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        Card(
          elevation: 1.5,
          child: InkWell(
            onTap: editCash,
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextWithIcon(
                          fillColor: fillColor,
                          icon: icon,
                          text: widget.cash.category,
                        ),
                      ),
                      if (hasMember)
                        Expanded(
                          flex: 2,
                          child: Text(widget.cash.member),
                        ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(addCurrency(widget.cash.price)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
