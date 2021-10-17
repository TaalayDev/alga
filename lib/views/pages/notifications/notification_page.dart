import 'package:alga/utils/notifications_manager.dart';
import 'package:alga/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final _titleTextController = TextEditingController();
  final _textController = TextEditingController();

  NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('Отправить уведомление')),
      body: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
          children: [
            TextField(
              controller: _titleTextController,
              decoration: InputDecoration(
                hintText: 'Загаловок',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Текст',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await PushNotificationsManager().sendPushMessage(
                    _titleTextController.text, _textController.text);
                _titleTextController.text = '';
                _textController.text = '';
              },
              child: Text('Отправить'),
            ),
          ],
        ),
      ),
    );
  }
}
