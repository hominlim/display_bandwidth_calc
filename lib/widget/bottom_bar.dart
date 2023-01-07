import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Container(
          height: 50,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.aspect_ratio,
                  size: 18,
                ),
                child: Text(
                  'Input Parameter',
                  style: TextStyle(fontSize: 9),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.memory,
                  size: 18,
                ),
                child: Text(
                  'Calculatrion',
                  style: TextStyle(fontSize: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
