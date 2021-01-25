import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  children: [
                    _FeatureItem(
                      'Transfer',
                      Icons.monetization_on,
                      onClick: () => _showContactList(context),
                    ),
                    _FeatureItem(
                      'Transiction Feed',
                      Icons.description,
                      onClick: () => _showTransactionsList(context),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showContactList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactList(),
    ));
  }

  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ));
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {@required this.onClick})
      : assert(icon != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      onTap: () => onClick(),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32.0,
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: inkWell,
      ),
    );
  }
}
