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

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<MusicProvider>().loadFeaturedTracks();
    } else {
      context.read<MusicProvider>().searchTracks(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(backgroundColor: AppTheme.bg, title: CustomAppBar()),
      body: Column(
        // ← Change Stack to Column
        children: [
          Expanded(
            // ← Wrap scroll content in Expanded
            child: SingleChildScrollView(
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
                            onChanged: (value) => _onSearchChanged(value),
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              hintText: 'Search for songs, artists...',
                              hintStyle: TextStyle(
                                color: AppTheme.textSecondary,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchController.clear();
                                          context
                                              .read<MusicProvider>()
                                              .clearSearch();
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
                            searchController.text.isEmpty
                                ? 'Featured Tracks'
                                : 'Search Results for "${searchController.text}"',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
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
                                      musicProvider
                                          .queue[index]
                                          .durationFormatted,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
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
                                  musicProvider.playSong(
                                    musicProvider.queue[index],
                                  );
                                },
                              );
                            },
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                          ),

                          SizedBox(
                            height: 80,
                          ), // ← Add bottom padding so last item not hidden behind player
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          _bottomPlayer(), // ← Moved HERE — fixed at bottom
        ],
      ),
    );
  }

  Widget _bottomPlayer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      height: 70,
      color: AppTheme.card,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Song Title',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                ),
              ),
              Text(
                'Artist Name',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next)),
        ],
      ),
    );
  }
}
