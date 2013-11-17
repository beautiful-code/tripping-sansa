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

    this.pollMessagesListener();
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

        new_message = {
          user_email: UserConfig.user_email,
          content: ChatSession.ci.val(),
          clip: clip
        };

        ChatSession.addMessage(new_message, true);

        ChatSession.ci.val('');
        ImageCenter.clear();
      }
    });
    
  },

  pollMessagesListener: function() {
    window.setInterval(function() {
      console.log("Polling messages");
    }, 2000);
  },

  addMessage: function(message, post_flag) {
    //Post the message back to the server
    
    if(post_flag)
      $.post( "/rooms/" + RoomConfig.room_id + "/add_message", { user_id: UserConfig.id, content: message.content, clip: message.clip })
        .done(function( data ) {
          // All went well. Append data attributes of the saved message
      });

    // Render the message
    var new_message = ChatSession.message_template.clone();
    new_message.removeClass('message-template').addClass('message');

    new_message.find('.author').text(message.user_email + ": ");
    new_message.find('.content').text(message.content);
    if(message.clip)
      new_message.find('img').attr('src', message.clip.file_path);
    ChatSession.cw.append(new_message);

    ChatSession.cw.animate({ scrollTop: ChatSession.cw.get(0).scrollHeight}, 1000);
  },

  loadExistingMessages: function() {

    $.getJSON( "/rooms/" + RoomConfig.room_id + ".json", function( data ) {
      $.each( data.messages, function( index, message ) {
        ChatSession.addMessage(message, false);
      });
    });

  }
};

$(function() {
  if($('#chat_session').length > 0 ) {
    ChatSession.init('#chat_session');
  }
});
