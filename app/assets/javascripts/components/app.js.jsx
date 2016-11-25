class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {tweets: props.tweets};
  }

  componentDidMount() {
    GlobalDispatcher.setTarget(this);
  }

  onTweetDeleted(tweetId) {
    let tweets = this.state.tweets.filter(tweet => tweet.id !== tweetId);
    this.setState({tweets: tweets});
  }

  onTweetReceived(tweet) {
    if(!this.props.displayIncoming) return;

    let tweets = [tweet].concat(this.state.tweets);
    this.setState({tweets: tweets});
  }

  render() {
    let renderTweet = (tweet) => <Tweet key={tweet.id}
                                        currentUserId={this.props.currentUserId}
                                        userId={tweet.userId}
                                        tweetId={tweet.id}
                                        username={tweet.username}
                                        displayName={tweet.displayName}
                                        body={tweet.body} />
    let tweets = this.state.tweets.length > 0 ? this.state.tweets.map(renderTweet)
                                              : <div>No tweets found.</div>;
    return (
      <div className="wrapper">
        <div className="header">
          <a href="/"><h1>Fake Twitter</h1></a>
          {this.props.currentUserId ? <TweetBox /> : <a href='/users/sign_in'>Sign In</a>}
          <SearchBox />
        </div>
        <div className="main">
          <div className="tweet-list">
            {tweets}
          </div>
        </div>
      </div>
    );
  }
}
