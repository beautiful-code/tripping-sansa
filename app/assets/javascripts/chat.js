var ChatSession = {
  cs: null,
  cw: null,
  ci: null,
  message_template: null,

  init: function(selector) {
    this.cs = $(selector);
    this.cw = this.cs.find('#chat_window');
    this.ci = this.cs.find('#chat_input input');

    this.message_template = this.cs.find('.message-template');

    this.addMessageListener();

    this.loadExistingMessages();
  },

  addMessageListener: function() {
    ChatSession.ci.keydown(function(event){
      if(event.keyCode == '13') {

        clip = null;
        if(ImageCenter.selectedImage() != null) {
          clip = {
            file_path: ImageCenter.selectedImage().path,
            id: ImageCenter.selectedImage().id
          }
        }

        ChatSession.addMessage(UserConfig.user_email, ChatSession.ci.val(), clip, true);
        ChatSession.ci.val('');
        ImageCenter.clear();
      }
    });
    
  },

  addMessage: function(author, content, clip, post_flag) {
    //Post the message back to the server
    
    if(post_flag)
      $.post( "/rooms/" + RoomConfig.room_id + "/add_message", { user_id: UserConfig.id, content: content, clip: clip })
        .done(function( data ) {
          // All went well.
      });

    // Render the message
    var new_message = ChatSession.message_template.clone();
    new_message.removeClass('message-template').addClass('message');

    new_message.find('.author').text(author + ": ");
    new_message.find('.content').text(content);
    if(clip)
      new_message.find('img').attr('src', clip.file_path);
    ChatSession.cw.append(new_message);

    ChatSession.cw.animate({ scrollTop: ChatSession.cw.get(0).scrollHeight}, 1000);
  },

  loadExistingMessages: function() {

    $.getJSON( "/rooms/" + RoomConfig.room_id + ".json", function( data ) {
      $.each( data.messages, function( index, message ) {
        ChatSession.addMessage(message.user_email, message.content, message.clip, false);
      });
    });

  }
};

$(function() {
  ChatSession.init('#chat_session');
});
