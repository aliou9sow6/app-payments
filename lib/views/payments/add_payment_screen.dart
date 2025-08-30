import 'package:flutter/material.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paiements'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.payment), text: 'Effectuer un paiement'),
            Tab(icon: Icon(Icons.history), text: 'Historique'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Onglet pour effectuer un paiement
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logique pour effectuer un paiement
                print('Paiement effectué');
              },
              child: Text('Effectuer un paiement'),
            ),
          ),
          // Onglet pour afficher l'historique des paiements
          Center(child: Text('Historique des paiements')),
        ],
      ),
    );
  }
}
