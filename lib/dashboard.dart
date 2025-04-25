import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Order _order = Order();

  String? validateItem(String item){
    return item.isEmpty ? 'Item required' : null;
  }

  String? validateQuantity(String quantity){
    int? intQuantity = quantity.isEmpty ? 0 : int.tryParse(quantity);
    return intQuantity == 0 ? "At least one item is required" : null;
  }

  void submitOrder(){
    if (_formStateKey.currentState!.validate()){
      _formStateKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item : ${_order.item} \nQuantity: ${_order.quantity}"),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title : Text("Form Validation"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Form(
              key: _formStateKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(32.0),
                    child: Column(
                      children: <Widget>[                    
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Coffee",
                            labelText: "Item",
                          ),
                          validator: (value) => validateItem(value!),
                          onSaved: (value) => _order.item = value!,
                        ),
                  
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Quantity",
                            hintText: "2",
                          ),
                          validator: (value) => validateQuantity(value!),
                          onSaved: (value) => _order.quantity = int.tryParse(value!)!
                        )
                      ]
                    )
                  ),
                  ElevatedButton(
                    onPressed: (){
                      submitOrder();
                    },
                    child: Text("Submit"),
                  )
                ]   
              )
            )
          ],
        ),
      )
    );
  }
}

class Order{
  late String item;
  late int quantity;
}