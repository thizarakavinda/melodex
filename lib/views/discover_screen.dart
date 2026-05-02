import 'package:flutter/material.dart';
import 'package:melodex/theme/app_theme.dart';
import 'package:melodex/widgets/custom_app_bar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(backgroundColor: AppTheme.bg, title: CustomAppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) => setState(() {}),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: 'Search for songs, artists...',
                  hintStyle: TextStyle(color: AppTheme.textSecondary),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                          icon: const Icon(Icons.close),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppTheme.card,
                ),
              ),

              SizedBox(height: 30),

              Text(
                'Featured Tracks',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.tertiary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
