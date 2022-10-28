import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    String df = "";
    return SizedBox(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                const Text(
                  'No transactions added yet!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 79),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    height: 240,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                if (df ==
                    DateFormat('dd/MM/yyyy').format(transactions[index].date)) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 10),
                          width: 2,
                          height: MediaQuery.of(context).size.height / 30,
                          alignment: Alignment.topRight,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: transactions[index].type == "Expense"
                                        ? const Color.fromARGB(255, 179, 3, 3)
                                        : const Color.fromARGB(
                                            255, 33, 150, 243),
                                    width: 2)),
                            padding: const EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                "₹${transactions[index].amount.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: transactions[index].type == "Expense"
                                      ? const Color.fromARGB(255, 179, 3, 3)
                                      : const Color.fromARGB(255, 33, 150, 243),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transactions[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 150,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(transactions[index].date),
                                style: const TextStyle(
                                  color: Color.fromARGB(125, 255, 255, 255),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteTx(transactions[index].id),
                          color: Colors.white,
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          onPressed: () => deleteTx(transactions[index].id),
                          color: Colors.white,
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ],
                    ),
                  );
                } else {
                  df =
                      DateFormat('dd/MM/yyyy').format(transactions[index].date);
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height / 100),
                                height: MediaQuery.of(context).size.height / 22,
                                width: MediaQuery.of(context).size.width / 5,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: FittedBox(
                                  child: Text(DateFormat('EEE')
                                      .format(transactions[index].date)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 20,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(transactions[index].date),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.only(
                                  top: 15, left: 10, right: 10),
                              width: 2,
                              height: MediaQuery.of(context).size.height / 30,
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: transactions[index].type ==
                                                "Expense"
                                            ? const Color.fromARGB(
                                                255, 179, 3, 3)
                                            : const Color.fromARGB(
                                                255, 33, 150, 243),
                                        width: 2)),
                                padding: const EdgeInsets.all(10),
                                child: FittedBox(
                                  child: Text(
                                    "₹${transactions[index].amount.toString()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: transactions[index].type ==
                                              "Expense"
                                          ? const Color.fromARGB(255, 179, 3, 3)
                                          : const Color.fromARGB(
                                              255, 33, 150, 243),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    transactions[index].title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(transactions[index].date),
                                    style: const TextStyle(
                                      color: Color.fromARGB(125, 255, 255, 255),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => deleteTx(transactions[index].id),
                              color: Colors.white,
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () => deleteTx(transactions[index].id),
                              color: Colors.white,
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
              itemCount: transactions.length,
            ),
    );
  }
}
