import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/presentation/cubit/search_for_transformer_cubit/search_for_transformer_cubit.dart';

import '../../../constants/list_and_maps.dart';
import '../../../di/dependency_injection.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SearchScreenBody());
  }
}

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  late StyleConstants styleConstants;
  late SearchForTransformerCubit _searchForTransformerCubit;

  @override
  void initState() {
    _searchForTransformerCubit = locator<SearchForTransformerCubit>();
    styleConstants = StyleConstants();
    _searchForTransformerCubit.emitSearchForTransformers("مثنى");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(styleConstants.largeDp),
      child: BlocProvider(
        create: (context) => _searchForTransformerCubit,
        child: Container(
          child: Column(
            children: [
              Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      TransformersSearchBarWidget(searchForTransformerCubit: _searchForTransformerCubit,),
                      SizedBox(
                        height: styleConstants.extraLargeDp,
                      ),
                      ActionChoiceExample(),
                      SizedBox(
                        height: styleConstants.extraLargeDp,
                      )
                    ],
                  )),
              Row(
                children: [
                  DropdownMenu(
                    dropdownMenuEntries: List.generate(
                        2,
                        (index) => DropdownMenuEntry(
                            value: index,
                            label:
                                ListAndMaps().sortAccordingToCapacity[index])),
                    initialSelection: 0,
                    inputDecorationTheme: const InputDecorationTheme(
                        enabledBorder: InputBorder.none),
                  )
                ],
              ),
              BlocBuilder<SearchForTransformerCubit, SearchForTransformerState>(
  builder: (context, state) {
    if (state is SearchForTransformerLoaded) {
      return Expanded(
        child: ListView.builder(
          itemCount: state.transformers.length,
          itemBuilder: (context, index) =>
              _buildTransformerSearchCard(state.transformers[index]),
          scrollDirection: Axis.vertical,
        ),
      );

      //return Container (child : _buildTransformerSearchCard(state.transformers[2]));
      //_buildTransformerSearchCard()
    }
     else if(state is SearchForTransformerError){
      return Center(child: Text("error"));
    }
    else{
      return CircularProgressIndicator();
    }
  },
)
              //_buildTransformerSearchCard()
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTransformerSearchCard(TransformerResource transformer) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.white,
        margin: EdgeInsets.all(styleConstants.largeDp),
        padding: EdgeInsets.all(styleConstants.extraLargeDp),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(styleConstants.largeDp),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (transformer.isItOverhead)
                          ? AssetImage("images/overhead.png")
                          : AssetImage("images/kiosk.png"))),
            ),
            SizedBox(
              height: styleConstants.extraLargeDp,
            ),
            Align(
              child: Text(
                "${transformer.transformerName} محولة كهربائية",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
              alignment: Alignment.centerRight,
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${transformer.transformerCapacity}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color:
                            Color(styleConstants.colorGrey).withOpacity(0.7)),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  "${transformer.feederName}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Color(styleConstants.colorGrey).withOpacity(0.7)),
                  textDirection: TextDirection.rtl,
                ),
              ],
            )
          ],
        ));
  }
}

class TransformersSearchBarWidget extends StatefulWidget {
  const TransformersSearchBarWidget({super.key, required this.searchForTransformerCubit});
  final SearchForTransformerCubit searchForTransformerCubit;
  @override
  State<TransformersSearchBarWidget> createState() =>
      _TransformersSearchBarWidgetState();
}

class _TransformersSearchBarWidgetState
    extends State<TransformersSearchBarWidget> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    StyleConstants styleConstants = StyleConstants();
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text("",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black))),
        TextField(
          onChanged: ((text){
             setState(() {
            widget.searchForTransformerCubit.emitSearchForTransformers(searchController.text);
             });
          }),
          textDirection: TextDirection.rtl,
          controller: searchController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(styleConstants.smallDp),
                borderSide: BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                ),
              ),
              hintText: "ابحث عن المحولات ...",
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Color(styleConstants.colorBlack).withOpacity(0.4)),
              hintTextDirection: TextDirection.rtl,
              fillColor: Color(0XFFF3F4F6),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(styleConstants.extraLargeDp),
                borderSide: BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                ),
              ),
              suffixIcon: Icon(Icons.search)),
        ),
      ],
    );
  }
}

class ActionChoiceExample extends StatefulWidget {
  const ActionChoiceExample({super.key});

  @override
  State<ActionChoiceExample> createState() => _ActionChoiceExampleState();
}

class _ActionChoiceExampleState extends State<ActionChoiceExample> {
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    List<String> textFilter =
        ListAndMaps().listOfFilteredText.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          child: Text(
            'اختر عنصر للفلترة',
            style: textTheme.labelLarge,
          ),
          alignment: Alignment.centerRight,
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(textFilter.length, (int index) {
              return ChoiceChip(
                label: _value == index
                    ? Text(
                        textFilter[index],
                        style: textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      )
                    : Text(
                        textFilter[index],
                        style: textTheme.titleMedium
                            ?.copyWith(color: Colors.black),
                      ),
                selected: _value == index,
                onSelected: (bool selected) {
                  if (selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  }
                },
                selectedColor: Colors.black,
                backgroundColor: Colors.white,
                checkmarkColor: index == _value ? Colors.white : Colors.black,
                //  avatar: Icon(Icons.check_circle_rounded, color: Colors.white,),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
