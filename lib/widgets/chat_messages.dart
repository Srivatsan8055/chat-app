import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget{
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final aunthenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(), 
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }
        final loadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40, 
            left: 13, 
            right: 13,
          ),
          reverse: true,
          itemCount: loadedMessages.length, 
          itemBuilder: (ctx, index) {
            final ChatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length 
                ? loadedMessages[index + 1].data() 
                : null;

            final currentMessageUserId = ChatMessage['userId'];
            final nextMessageUserId = 
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            if(nextUserIsSame) {
              return MessageBubble.next(
                message: ChatMessage['text'], 
                isMe: aunthenticatedUser.uid == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                username: ChatMessage['username'], 
                message: ChatMessage['text'], 
                isMe: aunthenticatedUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    ); 
  }
}