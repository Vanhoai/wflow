import 'package:flutter/material.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/widgets/button/button.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/utils/constants.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/input_group.dart';

class UpgradeBusinessScreen extends StatefulWidget {
  const UpgradeBusinessScreen({super.key});

  @override
  State<UpgradeBusinessScreen> createState() => _UpgradeBusinessScreenState();
}

class _UpgradeBusinessScreenState extends State<UpgradeBusinessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: AppSize.paddingScreenDefault,
            right: AppSize.paddingScreenDefault,
          ),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Avatar for business',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                width: double.infinity,
                height: ((MediaQuery.sizeOf(context).height) / 100) * 29.42,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                  child: InkWell(
                    onTap: () => {},
                    borderRadius: BorderRadius.circular(8),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 32,
                          color: Color(0XFFABABAB),
                        ),
                        Text(
                          'Upload here',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0XFFB8B8B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Wrap(
                children: List.generate(
                  inputs.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 28),
                    child: InputGroup(
                      labelText: inputs[index]['labelText'],
                      hintText: inputs[index]['hintText'],
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fee',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '200.000 VND',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              AppButton(
                onTap: () => {},
                text: 'Upgrade',
              ),
              const SizedBox(
                height: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
