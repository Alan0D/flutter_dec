import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dec/main.dart';
import 'package:flutter_dec/providers/chat_provider.dart';
import 'package:flutter_dec/widgets/message_input.dart';

void main() {
  testWidgets('Chat screen shows empty state message initially', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('No messages yet. Start a conversation!'), findsOneWidget);
    expect(find.text('Flutter Chat'), findsOneWidget);
  });

  testWidgets('MessageInput widget renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => ChatProvider(),
            child: const MessageInput(),
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);
  });

  testWidgets('Can type and send a message', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the input field and enter text
    await tester.enterText(find.byType(TextField), 'Hello, Flutter!');
    await tester.pump();

    // Tap the send button
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Verify the message is displayed
    expect(find.text('Hello, Flutter!'), findsOneWidget);
  });
}