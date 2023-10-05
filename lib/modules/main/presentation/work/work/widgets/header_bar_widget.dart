import 'package:flutter/material.dart';

class HeaderBarWidget extends StatefulWidget {
  const HeaderBarWidget({super.key});

  @override
  State<HeaderBarWidget> createState() => _HeaderBarWidgetState();
}

class _HeaderBarWidgetState extends State<HeaderBarWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://picsum.photos/200',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
                child: Text('WFlow',
                    style: themeData.textTheme.titleLarge!
                        .merge(const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))),
          ],
        ),
      ),
    );
  }
}
