import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

// NOTE: SingleTickerProviderStateMixin은 한 개의 애니메이션을 가진 위젯을 정의할 때 사용, 그 이상일 경우 TickerProviderStateMixin
class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    //NOTE: StateFulWidget에만 존재하는 초기화함수
    super.initState();
    //NOTE: vsync:this는 해당 위젯의 싱크를 SingleTickerProviderStateMixin에 맞춤
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTabBar(),
      Expanded(child: _buildTabBarView()),
    ]);
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(icon: Icon(Icons.feed_outlined, color: Colors.black87)),
        Tab(icon: Icon(Icons.photo_album_outlined, color: Colors.black87)),
      ],
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10, crossAxisCount: 3, mainAxisSpacing: 10),
            itemCount: 42,
            itemBuilder: (count, index) {
              return Image.network(
                  "https://picsum.photos/id/${index + 20}/200/200");
            }),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10, crossAxisCount: 3, mainAxisSpacing: 10),
            itemCount: 42,
            itemBuilder: (count, index) {
              return Image.network(
                  "https://picsum.photos/id/${index + 62}/200/200");
            }),
      ],
    );
  }
}
