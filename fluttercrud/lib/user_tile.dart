import 'package:flutter/material.dart';
import 'package:projeto_agtech/models/users.dart';
import 'package:projeto_agtech/routes/app_routes.dart';
import 'package:projeto_agtech/provider/users.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = (user.avatar ?? "").isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatar!));
    return ListTile(
      leading: avatar,
      title: Text(user.name!),
      subtitle: Text(user.email!),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.userForme,
                  arguments: user,
                );
              },
              icon: Icon(Icons.edit),
              color: const Color.fromARGB(255, 18, 155, 5),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Excluir Usuário"),
                    content: Text("Tem certeza?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Não"),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text("Sim"),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmou) {
                  if (confirmou) {
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
