import { screenshareMode, setButtonDisplay, streamLayout } from './app_helpers';

export default class Party {
  constructor(session) {
    this.session = session;
    this.watchLink = document.getElementById('watch-mode');
    this.subscribers = document.getElementById('subscribers');
    this.participantCount = document.getElementById("participant-count");
    this.videoPublisher = this.setupVideoPublisher();
    this.clickStatus = 'off';
    this.setEventHandlers();
    this.connectionCount = 0;
    setButtonDisplay(this.watchLink);
  }

    setupVideoPublisher() {
      return Option.initPublisher('publisher', {
        insertMode: 'append',
        width: "100%",
        height: "100%"
      }, (error) {
        if (error) {
          console.error('Failed to initalise publisher', error);
        };
      });
    }
}
  setEventHandlers() {
    let self = this;
    this.session.on({
      sessionConnected: (event) => {
        self.session.publish(self.videoPublisher, (error) {
          if (error) {
            console.error('Failed to publish', error);
          }
        });
      },

      streamCreated: (event) => {
        self.session.subscribe(event.stream, 'subscirbers', {
          insertMode: 'append',
          width: '100%',
          height: '100%'
        }, (error) => {
          if (error) {
            console.error('Failed to subscribe', error);
          }
        });

      },
      connectionCreated: (event) => {
        self.connectionCount++;
        self.participantCount.textContent = `${self.connectionCount} Participants`;
        streamLayout(self.subscribers, self.connectionCount);
      },

      connectionDestroyed: (event) => {
        self.connectionCount--;
        self.participantCount.textContent = `${self.connectionCount} Participants`;
        streamLayout(self.subscribers, self.connectionCount);
      }
    });

    this.watchLink.addEventListener('click', (event) => {
      event.preventDefault();
      if (self.clickStatus == 'off') {
        screenshareMode(self.session, 'on');
      };
    });
  }