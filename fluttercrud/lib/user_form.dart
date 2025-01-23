import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projeto_agtech/models/users.dart';
import 'package:projeto_agtech/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User? user) {
    if (user != null) {
      _formData["id"] = user.id ?? "";
      _formData["Nome"] = user.name ?? "";
      _formData["email"] = user.email ?? "";
      _formData["avatar"] = user.avatar ?? "";
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments as User?;

    _loadFormData(user);
  }

  // Adicionado o parâmetro 'key'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastramento de usuário"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                final eValido = _form.currentState!.validate();

                if (eValido) {
                  _form.currentState?.save();
                  Provider.of<Users>(context, listen: false).put(User(
                    id: _formData["id"],
                    name: _formData["name"],
                    email: _formData["email"],
                    avatar: _formData["avatar"],
                  ));
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _formData["name"],
                  decoration: InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ("Insira um nome!");
                    }
                    if (value.trim().length < 3) {
                      return ("Nome necessita no mínimo mais de 3 caracteres");
                    }

                    return null;
                  },
                  onSaved: (value) => _formData["name"] = value!,
                ),
                TextFormField(
                  initialValue: _formData["email"],
                  decoration: InputDecoration(labelText: "E-mail"),
                  onSaved: (value) => _formData["email"] = value!,
                ),
                TextFormField(
                  initialValue: _formData["avatar"],
                  decoration: InputDecoration(labelText: "Avatar"),
                  onSaved: (value) => _formData["avatar"] = value ?? "",
                ),
              ],
            )),
      ),
    );
  }
}
