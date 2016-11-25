class TweetBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {tweeting: false, value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.startTweeting = this.startTweeting.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(ev) {
    this.setState({value: '', tweeting: false})

    $.ajax({
      method: 'post',
      url: 'tweets/create',
      data: {body: this.state.value},
      success: (tweet) => {
        GlobalDispatcher.tweetReceived(tweet);
      }
    })
  }

  handleChange(ev) {
    this.setState({value: ev.target.value});
  }

  startTweeting(ev) {
    this.setState({tweeting: true});
    ev.preventDefault();
  }

  render() {
    let content;
    if(this.state.tweeting) {
      console.log(this.state)
      let charsRemaining = 140 - this.state.value.length;
      let submitDisabled = charsRemaining === 140 || charsRemaining < 0;

      content = <div>
                  <textarea value={this.state.value} onChange={this.handleChange} />
                  <span>Characters remaining: {charsRemaining}</span>
                  <button type="button" disabled={submitDisabled} onClick={this.handleSubmit}>
                    Submit
                  </button>
                </div>
    } else {
      content = <a href="#" onClick={this.startTweeting}>Create Tweet!</a>
    }

    return <div className="tweet-box">
             {content}
           </div>
  }
}
