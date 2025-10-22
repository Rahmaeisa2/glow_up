import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/local_cache.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/widget/responsive.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> mealData = [];
  List<String> mealHistory = [];
  bool hasSearched = false;
  bool isLoading= false;
  Timer? _debounce;
  String? errorMessage;

  Future<List<Map<String,dynamic>>> searchMeal(String query) async {
    query = _controller.text.trim();
    if (query.isEmpty) {
      setState(() {
        mealData = [];
        hasSearched = false;
        isLoading = false;
        errorMessage = null;
      });
      return [];
    }
      setState(() {
        isLoading = true;
        hasSearched = true;
      });


      try{

    if (!mealHistory.contains(query) && query.isNotEmpty) {
      mealHistory.add(query);
      await LocalCache.saveMeals(mealHistory.map((e) => {'query': e}).toList());
    }

      final snapshot = await FirebaseFirestore.instance
          .collection("meals")
          .where('namelower', isGreaterThanOrEqualTo: query.toLowerCase())
          .where('namelower', isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff')
          .get();

      print("Documents found: ${snapshot.docs.length}");
      final results = snapshot.docs.map((doc) => doc.data()).toList();


    setState(() {
      mealData = results;
      isLoading = false;
      hasSearched=true;
    });
      if (results.isNotEmpty) {
        print("Meals found: ${mealData.length}");
      } else {
        print("No meal found for '$query'");
      }
      return results;
    } catch (e) {
        setState(() {
          mealData = [];
          isLoading = false;
        });
        print('❌ Search error: $e');
      }
      return[];
  }


  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchMeal(query.trim());
    });
  }
  @override
  void initState() {
    super.initState();

    mealData = [];
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Search"),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              onChanged: onSearchChanged,
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:  BorderSide(color:Theme.of(context).colorScheme.primary),
                ),
                hintText: 'Enter meal name...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search), onPressed: () {  },
                ),
              ),
            ),
            SizedBox(height: 12,),

            const SizedBox(height: 20),
            Expanded(
              child:RefreshIndicator(
                  onRefresh: () async {
                   await searchMeal(_controller.text.trim());

                  },
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : errorMessage != null
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red),
                        Text(errorMessage!),
                        ElevatedButton(
                          onPressed: () => searchMeal(_controller.text.trim()),
                          child: Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  )
                      : mealData.isEmpty && hasSearched
                      ? Center(child: Text('No result match"${_controller.text}"'))
                      : mealData.isEmpty
                      ? Center(child: Text('Start searching...'))

                  : ListView.builder(

                      physics: AlwaysScrollableScrollPhysics(),
                  itemCount: mealData.length,
                  itemBuilder: (context, index) {
                    final meal = mealData[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(

                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: ListTile(
                        title: Text(
                          meal['name'] ?? 'No name',
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "Calories: ${meal['calories']} | Protien: ${meal['protien']}",
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

        ) )

      )
          ]
        ),
      ),
    );
  }
}