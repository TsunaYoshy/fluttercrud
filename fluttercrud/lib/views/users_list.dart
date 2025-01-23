import 'package:flutter/material.dart';
import 'package:projeto_agtech/routes/app_routes.dart';
import 'package:projeto_agtech/widgets/user_tile.dart';
import 'package:provider/provider.dart';
import 'package:projeto_agtech/provider/users.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Usuários Cadastrados"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.userForme);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
