import 'package:flutter/material.dart';
import 'package:wflow/core/theme/size.dart';

class WorkCard extends StatefulWidget {
  const WorkCard({
    super.key,
    required this.position,
    required this.company,
    required this.content,
    required this.image,
  });

  final String position;
  final String company;
  final String content;
  final String image;

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Ink(
        padding: const EdgeInsets.only(
          left: AppSize.paddingScreenDefault,
          right: AppSize.paddingScreenDefault,
          top: AppSize.paddingMedium * 2,
          bottom: AppSize.paddingMedium * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(widget.image),
                SizedBox(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildPosition(widget.position, widget.company),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: _buildContent(widget.content),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String image) {
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 15.3,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 7.32,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width,
        backgroundImage: NetworkImage(image),
      ),
    );
  }

  Widget _buildPosition(String position, String company) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          Text(
            company,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade400,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(String content) {
    return SizedBox(
      child: Text(
        content,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        maxLines: 3,
      ),
    );
  }
}
