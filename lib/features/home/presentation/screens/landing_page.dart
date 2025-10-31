import 'package:almasah_dates/features/home/presentation/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ...

class LandingPage extends StatefulWidget {
  final Function(int) onMenuSelect;
  LandingPage({required this.onMenuSelect});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    // ✅ Load items once when the screen opens
    Future.microtask(() => context.read<HomeProvider>().loadHomes());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
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
                              Text(
                                'مبلغ الدين',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .032,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    size:
                                        MediaQuery.of(context).size.width * .05,
                                    // weight: 300,
                                  ),
                                  Text('${(provider.home.sumPORemain*100).round() /100}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color: Color.fromARGB(255, 0, 134, 29),
                                    size:
                                        MediaQuery.of(context).size.width * .05,
                                    // weight: 300,
                                  ),
                                  Text('${(provider.home.sumSORemain*100).round() /100}'),
                                ],
                              ),
                              // Text('Balance'),
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
                              Text(
                                'المبلغ الإحاملي',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .032,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    size:
                                        MediaQuery.of(context).size.width * .05,
                                    // weight: 300,
                                  ),
                                  Text('${(provider.home.sumPO*100).round() /100}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color: Color.fromARGB(255, 0, 134, 29),
                                    size:
                                        MediaQuery.of(context).size.width * .05,
                                    // weight: 300,
                                  ),
                                  Text('${(provider.home.sumSO*100).round() /100}'),
                                ],
                              ),
                              // Text('Balance'),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'المستودع',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          .032,
                                    ),
                                  ),
                                  Icon(
                                    Icons.store_mall_directory_rounded,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    size:
                                        MediaQuery.of(context).size.width * .05,
                                    // weight: 300,
                                  ),
                                ],
                              ),
                              Row(children: [Text('${provider.home.sumPO}')]),
                              // Text('Balance'),
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
          ],
        ),
      ),
    );
  }
}
