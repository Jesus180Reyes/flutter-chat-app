import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final by = Provider.of<SocketService>(context).by;
    final socket = Provider.of<SocketService>(context).serverStatus;
    final size = MediaQuery.of(context).size;
    final statusConnection = Provider.of<SocketService>(context).serverStatus;

    if (statusConnection == ServerStatus.connecting) return const LoadingPage();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.circle,
          color: socket == ServerStatus.online ? Colors.green : Colors.red,
        ),
        title: Text(by),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        child: const _MessagesBox(),
      ),
    );
  }
}

class _MessagesBox extends StatelessWidget {
  const _MessagesBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? messageController = TextEditingController();
    final socket = Provider.of<SocketService>(context).messages;
    final send = Provider.of<SocketService>(context);
    final by = Provider.of<SocketService>(context).by;
    final date = DateTime.now().toUtc();
    return Column(
      children: [
        DateChip(
          date: DateTime(date.year, date.month, date.day),
          color: const Color(0x558AD3D5),
        ),
        ...socket.map(
          (e) {
            return BubbleSpecialThree(
              isSender: by != e["by"] ? true : false,
              text: e["message"],
              color: by != e["by"] ? const Color(0xFF1B97F3) : Colors.grey,
              tail: false,
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            );
          },
        ).toList(),
        const Spacer(),
        MessageBar(
          onTextChanged: (text) {
            messageController.text = text;
          },
          onSend: (_) {
            send.sendMessage(message: messageController.text);
          },
        ),
      ],
    );
  }
}
