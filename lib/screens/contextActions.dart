import 'package:flutter/material.dart';

class ContextActions extends StatefulWidget {
  const ContextActions({Key? key}) : super(key: key);

  @override
  State<ContextActions> createState() => _ContextActionsState();
}

class _ContextActionsState extends State<ContextActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white70,
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            bottom: 100,
            right: 10,
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              color: Colors.white,
              height: 250,
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  // const Divider(color: Colors.pink,),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                  //  const Divider(color: Colors.pink,),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                  ),
                  //  const Divider(color: Colors.pink,),
                  Container(
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.support_agent,
                        color: Colors.deepPurple,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
