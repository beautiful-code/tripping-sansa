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

    this.cw.append("Chat initialized.");
  },

  addMessageListener: function() {
    ChatSession.ci.keydown(function(event){
      if(event.keyCode == '13') {
        ChatSession.addMessage('Ravi', ChatSession.ci.val());
        ChatSession.ci.val('');
        ImageCenter.clear();
      }
    });
    
  },

  addMessage: function(author, content) {
    var new_message = ChatSession.message_template.clone();
    new_message.removeClass('message-template').addClass('message');
    if(ImageCenter.selectedImage() != null) {
      new_message.find('img').attr('src', ImageCenter.selectedImage());
    }

    new_message.find('.author').text(author + ": ");
    new_message.find('.content').text(content);
    ChatSession.cw.append(new_message);

    ChatSession.cw.animate({ scrollTop: ChatSession.cw.get(0).scrollHeight}, 1000);
  },
};

$(function() {
  ChatSession.init('#chat_session');
});
