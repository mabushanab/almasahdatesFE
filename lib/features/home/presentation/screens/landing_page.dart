import 'package:almasah_dates/features/home/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';

// ...

class LandingPage extends StatefulWidget {
  final Function(int) onMenuSelect;
  LandingPage({required this.onMenuSelect});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () => {},
        child: Text('data'),
      ),
      appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // spacing: MediaQuery.of(context).size.width * .25,
                  children: [
                    TextButton(
                      onPressed: () => {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                    
                                size: MediaQuery.of(context).size.width * .05,
                                // weight: 300,
                              ),
                              // Text('Balance'),
                              Text('Credit: 500'),
                              Text('Debit: -200'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                    
                                size: MediaQuery.of(context).size.width * .05,
                                // weight: 300,
                              ),
                              // Text('Balance'),
                              Text('Credit: 500'),
                              Text('Debit: -200'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                    
                                size: MediaQuery.of(context).size.width * .05,
                                // weight: 300,
                              ),
                              // Text('Balance'),
                              Text('Credit: 500'),
                              Text('Debit: -200'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.store_mall_directory_rounded,
                    
                                size: MediaQuery.of(context).size.width * .05,
                                // weight: 300,
                              ),
                              // Text('Balance'),
                              Text('3 items need to filled'),
                              Text(''),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.insert_chart_outlined,
                    
                                size: MediaQuery.of(context).size.width * .05,
                                // weight: 300,
                              ),
                              // Text('Balance'),
                              Text('Purchase: 50000'),
                              Text('Sell: 2000'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                bottom: MediaQuery.of(context).size.height * .05,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: MediaQuery.of(context).size.width * .25,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      // MyHomePage hp = MyHomePage();
                      widget.onMenuSelect(4);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: MediaQuery.of(context).size.width * .25,
                            // weight: 300,
                          ),
                          // Text(data)
                          Text('+ Merchants'),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () => {},
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: MediaQuery.of(context).size.width * .25,
                            // semanticLabel: 'Customers',
                          ),
                          // Text(data)
                          Text('Customers'),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () => {},
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.category,
                            size: MediaQuery.of(context).size.width * .25,
                            // semanticLabel: 'Merchants',
                          ),
                          // Text(data)
                          Text('Items'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                bottom: MediaQuery.of(context).size.height * .05,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: MediaQuery.of(context).size.width * .25,
              children: [
                TextButton(
                  onPressed: () {
                    // MyHomePage hp = MyHomePage();
                    widget.onMenuSelect(4);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Icon(
                          Icons.people,
                          size: MediaQuery.of(context).size.width * .25,
                          // weight: 300,
                        ),
                        // Text(data)
                        Text('+ Merchants'),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Card(
                    child: Column(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: MediaQuery.of(context).size.width * .25,
                          // semanticLabel: 'Customers',
                        ),
                        // Text(data)
                        Text('Customers'),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Card(
                    child: Column(
                      children: [
                        Icon(
                          Icons.category,
                          size: MediaQuery.of(context).size.width * .25,
                          // semanticLabel: 'Merchants',
                        ),
                        // Text(data)
                        Text('Items'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                bottom: MediaQuery.of(context).size.height * .05,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: MediaQuery.of(context).size.width * .25,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      // MyHomePage hp = MyHomePage();
                      widget.onMenuSelect(4);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: MediaQuery.of(context).size.width * .25,
                            // weight: 300,
                          ),
                          // Text(data)
                          Text('+ Merchants'),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () => {},
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: MediaQuery.of(context).size.width * .25,
                            // semanticLabel: 'Customers',
                          ),
                          // Text(data)
                          Text('Customers'),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () => {},
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.category,
                            size: MediaQuery.of(context).size.width * .25,
                            // semanticLabel: 'Merchants',
                          ),
                          // Text(data)
                          Text('Items'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                bottom: MediaQuery.of(context).size.height * .05,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: MediaQuery.of(context).size.width * .25,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      // MyHomePage hp = MyHomePage();
                      widget.onMenuSelect(4);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: MediaQuery.of(context).size.width * .25,
                            // weight: 300,
                          ),
                          // Text(data)
                          Text('+ Merchants'),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () => {},
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: MediaQuery.of(context).size.width * .25,
                            // semanticLabel: 'Customers',
                          ),
                          // Text(data)
                          Text('Customers'),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () => {},
                    child: Card(
                      child: Column(
                        children: [
                          Icon(
                            Icons.category,
                            size: MediaQuery.of(context).size.width * .25,
                            // semanticLabel: 'Merchants',
                          ),
                          // Text(data)
                          Text('Items'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
