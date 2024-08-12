import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visible Items Example'),
      ),
      body: const SafeArea(child: CustomListView()),
    );
  }
}

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  CustomListViewState createState() => CustomListViewState();
}

class CustomListViewState extends State<CustomListView> {
  final GlobalKey listKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {}; // Store GlobalKeys for each item
  List<int> _visibleItems = [];
  bool _repositioning = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    List<int> visibleItems = [];

    final RenderBox? listViewBox =
        listKey.currentContext?.findRenderObject() as RenderBox?;
    if (listViewBox == null) return;

    final listViewPosition = listViewBox.localToGlobal(Offset.zero);
    final listViewHeight = listViewBox.size.height;

    _itemKeys.forEach((index, key) {
      if (key.currentContext == null) return;

      final RenderBox renderBox =
          key.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      // Check if the widget is within the visible screen bounds
      if (position.dy < listViewPosition.dy + listViewHeight &&
          position.dy + renderBox.size.height > listViewPosition.dy) {
        visibleItems.add(index);
      }
    });

    setState(() => _visibleItems = visibleItems);
  }

  void _onScrollEnd(double pixels) {
    if (_visibleItems.isEmpty) return;

    final RenderBox? listViewBox =
        listKey.currentContext?.findRenderObject() as RenderBox?;

    if (listViewBox == null) return;

    final listViewPosition = listViewBox.localToGlobal(Offset.zero);
    double nearestDistance = double.infinity;

    // Find the nearest item to the top
    for (int index in _visibleItems) {
      final RenderBox renderBox =
          _itemKeys[index]!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final distance = position.dy - listViewPosition.dy;

      if (distance.abs() < nearestDistance.abs()) {
        nearestDistance = distance;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _repositioning = true;
      _scrollController
          .animateTo(
            pixels + nearestDistance,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
          .then((_) => setState(() => _repositioning = false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (!_repositioning) {
                  _onScrollEnd(notification.metrics.pixels);
                }
              }

              return true;
            },
            child: ListView.builder(
              key: listKey,
              controller: _scrollController,
              physics: const CustomScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              itemCount: 100,
              itemBuilder: (context, index) {
                if (!_itemKeys.containsKey(index)) {
                  _itemKeys[index] = GlobalKey();
                }

                return Container(
                  key: _itemKeys[index],
                  height: 50 * (index % 3 + 1),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  color: index.isEven ? Colors.blue[100] : Colors.green[100],
                  child: ListTile(
                    title: Text('Item $index'),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Visible items: ${_visibleItems.join(', ')}'),
        ),
      ],
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({super.parent});

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    return FrictionSimulation(0.15, position.pixels, velocity);
  }
}
