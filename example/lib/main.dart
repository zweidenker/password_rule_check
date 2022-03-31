import 'package:flutter/material.dart';
import 'package:password_rule_check/password_rule_check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  ExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  TextEditingController _controller = TextEditingController();
  GlobalKey<PasswordRuleCheckState> _ruleCheckKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.dispose();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Enter Password'),
                validator: (_) {
                  if (_ruleCheckKey.currentState?.validate() == false) {
                    return 'Password does not meet standard';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 8,
              ),
              PasswordRuleCheck(
                key: _ruleCheckKey,
                controller: _controller,
                ruleSet: PasswordRuleSet(
                  minLength: 6,
                  uppercase: 1,
                  lowercase: 1,
                  specialCharacters: 1,
                  digits: 2,
                ),
                successColor: const Color(0xFF4E91DF),
                textStyle: Theme.of(context).textTheme.headline6,
                showIcon: true,
                rowHeight: 12,
                rowRadius: BorderRadius.circular(12),
                rowSpacing: 8,
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                child: Text('Validate Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
