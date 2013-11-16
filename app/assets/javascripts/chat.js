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
          clip = {file_path: ImageCenter.selectedImage()}
        }

        ChatSession.addMessage('Ravi', ChatSession.ci.val(), clip);
        ChatSession.ci.val('');
        ImageCenter.clear();
      }
    });
    
  },

  addMessage: function(author, content, clip) {
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
        ChatSession.addMessage(message.user_email, message.content, message.clip);
      });
    });

  }
};

$(function() {
  ChatSession.init('#chat_session');
});
