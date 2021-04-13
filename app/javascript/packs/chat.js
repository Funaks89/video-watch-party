import { formatChatMsg } from './app_helpers.js';

export default class Chat {
  constructor(session) {
    this.session = session;
    this.form = document.querySelector('form');
    this.msgTxt = document.querySelector('#message');
    this.msgHistory = document.querySelector('#history');
    this.chatWindow = document.querySelector('.chat');
    this.showChatBtn = document.querySelector('#showChat');
    this.closeChatbtn = document.querySelector('#closeChat');
    this.setupEventListeners();
  }
}

    setupEventListeners() {
      let self = this;
      this.form.addEventListener('submit', (event) => {
        event.preventDefault();

        self.session.signal({
          type: 'msg';
          data: formatChatMsg(self.msgTxt.value)
        }, (error) => {
          if(error) {
            console.log('Error sending signal:', error.name, error.message);
          } else {
            self.msgTxt.value = '';
          } 
        });
      });

      this.session.on('signal:msg', const signalCallback = (event) => {
        let msg = document.createElement('p');
        msg.textContent = event.data;
        msg.className = event.from.connecitonId === self.session.connection.connectionId ? 'mines' : 'theirs';
        self.msgHistory.appendChild(msg);
        msg.scrollIntoView();
      });

      this.showChatBtn.addEventListener('click', (event) => {
        self.chatWindow.classList.add('active');
      });

      this.closeChatbtn.addEventListener('click', (event) => {
        self.chatWindow.classList.remove('active');
      })
    } 