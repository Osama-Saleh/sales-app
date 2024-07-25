import 'package:flutter/material.dart';
import 'package:sales/ui/data/firbase_store/sales_items.dart';
import 'package:sales/ui/widgets/input_Buttom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: Salesitems.getItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data!.length == 0) {
                return Center(
                  child: Text('No sales items available'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title:
                            Text(snapshot.data![index].productName.toString()),
                        trailing:
                            Text(snapshot.data![index].productPrice.toString()),
                        leading: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            snapshot.data![index].productImage.toString(),
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/errorImage.jpg');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) {
              return Container(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: InputButtomSheet());
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
