import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/my_company_bloc.dart';

class CompanyInformationWidget extends StatefulWidget {
  const CompanyInformationWidget({super.key});

  @override
  State<CompanyInformationWidget> createState() => _CompanyInformationWidgetState();
}

class _CompanyInformationWidgetState extends State<CompanyInformationWidget> {
  Widget _buildTextWithIcon({required String title, required Icon icon, required ThemeData themeData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon,
        const SizedBox(width: 4),
        Flexible(
          child: Text(title.toString(), style: themeData.textTheme.displayMedium),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      bloc: instance.call<MyCompanyBloc>(),
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildTextWithIcon(
                title: state.companyEntity.address,
                icon: const Icon(Icons.location_on, shadows: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ]),
                themeData: themeData,
              ),
              const SizedBox(height: 2),
              _buildTextWithIcon(
                title: state.companyEntity.email,
                icon: const Icon(
                  Icons.email,
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                themeData: themeData,
              ),
              const SizedBox(height: 2),
              _buildTextWithIcon(
                title: state.companyEntity.phone,
                icon: const Icon(
                  Icons.phone,
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                themeData: themeData,
              ),
              const SizedBox(height: 2),
              _buildTextWithIcon(
                title: state.companyEntity.createdAt.toString(),
                icon: const Icon(
                  Icons.access_time_filled_sharp,
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                themeData: themeData,
              ),
              const SizedBox(height: 4),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              ),
            ],
          ),
        );
      },
    );
  }
}
