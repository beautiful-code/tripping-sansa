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
      }
    });
    
  },

  addMessage: function(author, content) {
    var new_message = ChatSession.message_template.clone();
    new_message.removeClass('.message-template').addClass('.message');
    new_message.find('.author').text(author + ": ");
    new_message.find('.content').text(content);
    ChatSession.cw.append(new_message);
  },
};

$(function() {
  ChatSession.init('#chat_session');
});
