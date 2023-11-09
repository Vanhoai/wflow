import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class StripeScreen extends StatefulWidget {
  const StripeScreen({super.key});

  @override
  State<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  final CardFormEditController cardFormEditController = CardFormEditController();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const AppHeader(
        text: 'Stripe',
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: CardFormField(
          controller: cardFormEditController,
        ),
      ),
    );
  }
}
