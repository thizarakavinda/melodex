import 'package:flutter/material.dart';
import 'package:melodex/providers/music_provider.dart';
import 'package:melodex/theme/app_theme.dart';
import 'package:melodex/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MusicProvider>().loadFeaturedTracks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(backgroundColor: AppTheme.bg, title: CustomAppBar()),
      body: SingleChildScrollView(
        child: Consumer<MusicProvider>(
          builder: (context, musicProvider, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8.0,
                ),
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

                    SizedBox(height: 20),

                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: musicProvider.queue.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              musicProvider.queue[index].imageUrl,
                            ),
                          ),
                          title: Text(
                            musicProvider.queue[index].name,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontSize: 14,
                                ),
                          ),
                          subtitle: Text(
                            musicProvider.queue[index].artistName,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppTheme.textSecondary,
                                  fontSize: 12,
                                ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              Text(
                                musicProvider.queue[index].durationFormatted,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: AppTheme.textSecondary,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(width: 4),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                          onTap: () {
                            musicProvider.playSong(musicProvider.queue[index]);
                          },
                        );
                      },
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
