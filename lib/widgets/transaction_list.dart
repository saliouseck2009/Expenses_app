import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTx;
  TransactionList(this.transactions, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (buildContext, index) {
                return TransactionItem(
                    transaction: transactions[index], deleteTx: _deleteTx);
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //           margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //           decoration: BoxDecoration(
                //               border: Border.all(color: Colors.purple, width: 2)),
                //           padding: EdgeInsets.all(10),
                //           child: Text(
                //             '${transactions[index].amount.toStringAsFixed(0)} fr',
                //             style: TextStyle(
                //                 color: Colors.purple,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20),
                //           )),
                //       Container(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               transactions[index].title,
                //               style: Theme.of(context).textTheme.headline6,
                //             ),
                //             Text(DateFormat.yMMMd().format(transactions[index].date),
                //                 style: TextStyle(
                //                     color: Colors.grey,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 17))
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
