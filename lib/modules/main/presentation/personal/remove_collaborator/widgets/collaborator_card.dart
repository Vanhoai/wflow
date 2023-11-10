import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';

class CollaboratorCard extends StatefulWidget {
  const CollaboratorCard({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.isCheck,
    required this.onCheck,
    required this.role,
  });

  final String image;
  final String name;
  final String email;
  final bool isCheck;
  final Function(bool?)? onCheck;
  final int role;

  @override
  State<CollaboratorCard> createState() => _CollaboratorCardState();
}

class _CollaboratorCardState extends State<CollaboratorCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingScreenDefault,
            vertical: AppSize.paddingMedium * 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAvatar(),
                  _buildContent(),
                  SizedBox(
                    width: ((MediaQuery.sizeOf(context).width) / 100) * 8.16,
                  ),
                  widget.role == 3 ? _buildCheckbox() : const SizedBox(),
                ],
              ),
              widget.role == 3
                  ? const Text(
                      'Collaborator',
                      style: TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        color: AppColors.greenColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : const Text(
                      'Creator',
                      style: TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        color: AppColors.redColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          )),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 12.75,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 6.1,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width,
        backgroundImage: NetworkImage(
          widget.image != ''
              ? widget.image
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw-rXpe_F2T_nvmUckfNWrGLnv9LvAoPNcbYVt_cLY7Q&s',
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 51.02,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name.trim(),
            style: textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.email.trim(),
            style: textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return Container(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 7.14,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 3.41,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: ((MediaQuery.sizeOf(context).width) / 100) * 0.51,
          style: BorderStyle.solid,
          color: widget.isCheck ? AppColors.primary : const Color(0XFFD9D9D9),
        ),
        borderRadius: BorderRadius.circular(AppSize.borderSmall),
      ),
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: widget.isCheck,
          onChanged: widget.onCheck,
          checkColor: AppColors.primary,
          side: const BorderSide(
            color: Colors.transparent,
          ),
          fillColor: const MaterialStatePropertyAll(Colors.white),
        ),
      ),
    );
  }
}
