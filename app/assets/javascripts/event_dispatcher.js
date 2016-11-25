class EventDispatcher {
  constructor() {
    this.target = null;
  }

  setTarget(target) { this.target = target; }
  tweetReceived(tweet) { this.target.onTweetReceived(tweet) }
  tweetDeleted(tweetId) { this.target.onTweetDeleted(tweetId) }
}

let GlobalDispatcher = new EventDispatcher();
