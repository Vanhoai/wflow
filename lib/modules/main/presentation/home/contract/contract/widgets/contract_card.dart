import 'package:flutter/material.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';

class ContractCard extends StatefulWidget {
  const ContractCard({
    super.key,
    required this.image,
    required this.name,
    required this.content,
    required this.status,
  });

  final String image;
  final String name;
  final String content;
  final String status;

  @override
  State<ContractCard> createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(RouteKeys.taskScreen),
      child: Ink(
        padding: const EdgeInsets.only(
          left: AppSize.paddingScreenDefault,
          right: AppSize.paddingScreenDefault,
          top: AppSize.paddingMedium * 2,
          bottom: AppSize.paddingMedium * 2,
        ),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(),
              SizedBox(
                width: ((MediaQuery.sizeOf(context).width) / 100) * 3.06,
              ),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 12.75,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 6.1,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width,
        backgroundImage: NetworkImage(
          widget.image,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.name,
                  style: themeData.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: ((MediaQuery.sizeOf(context).width) / 100) * 3.06,
              ),
              Text(
                widget.status,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0XFF4CAF50),
                ),
              ),
            ],
          ),
          SizedBox(
            width: ((MediaQuery.sizeOf(context).width) / 100) * 68.87,
            child: Text(
              widget.content,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
