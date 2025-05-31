import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/domain/update_all_transformers_remotely.dart';
import 'package:gis_helper/presentation/cubit/update_all_transformers_cubit/update_all_transformers_cubit.dart';

import '../../../data/resource/account_resource.dart';
import '../../../di/dependency_injection.dart';
import '../../cubit/all_transfomers_cubit/all_transformers_cubit.dart';
import '../../cubit/feeders_number_cubit/feeders_number_cubit.dart';
import '../../cubit/transformer_number_cubit/transformer_number_cubit.dart';
import '../../cubit/transformer_number_of_each_sector_cubit/transformer_number_of_each_sector_cubit.dart';
import '../../cubit/user_accountdata_cubit/user_accountdata_cubit.dart';
import '../data_entry_screen/data_entry_screen.dart';
import '../home_screen/home_screen.dart';
import '../search_screen/search_screen.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});


  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    context.read<UserAccountdataCubit>().emitUserAccountdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAccountdataCubit, UserAccountdataState>(
      builder: (context, state) {
        switch (state) {
          case UserAccountdataInitial():
            {
              return Center(child: CircularProgressIndicator());
            }
          case UserAccountdataSuccess():
            {
              AccountResource accountResource = state.userAccountdata;
              return _userSignInScaffold(accountResource);
            }
          case UserAccountdataError():
            {
              return Center(child: Text("error"));
            }
        }
      },
    );
  }

  Scaffold _userSignInScaffold(AccountResource accountResource) {
    List<Widget> pages = [
         HomeScreen(
        ),
      SearchScreen(userRole: accountResource.role),
      DataEntryScreen(),
    ];
    final List<BottomNavigationBarItem> navigationItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'الرئيسيه',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'بحث',
      ),
    ];

    // Add admin item if user is admin
    if (accountResource.role == "admin") {
      navigationItems.add(
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'إضافة',
        ),
      );
    }
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: navigationItems,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
