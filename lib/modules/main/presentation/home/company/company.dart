import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/company_bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (_) => instance.get<CompanyBloc>(),
      child: CommonScaffold(
        appBar: const AppHeader(),
        isSafe: true,
        body: Column(
          children: [
            const HeaderAvatarCompanyWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Posts',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    '20',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            BlocConsumer<CompanyBloc, CompanyState>(
                bloc: instance.call(),
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        instance.get<CompanyBloc>().add(const CompanyMyGetEvent());
                      },
                      child: const Text('TEST'));
                },
                listener: (context, state) {}),
            const Expanded(
              child: CompanyJobPostWidget(),
            )
          ],
        ),
      ),
    );
  }
}
