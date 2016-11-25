class Tweet extends React.Component {
  constructor(props) {
    super(props);
    this.handleDelete = this.handleDelete.bind(this);
  }

  handleDelete(ev) {
    GlobalDispatcher.tweetDeleted(this.props.tweetId);
    $.ajax({
      url: '/tweets/delete',
      method: 'post',
      data: {id: this.props.tweetId}
    });
  }

  render() {
    let deleteButton;
    if(this.props.currentUserId === this.props.userId) {
      deleteButton = <button onClick={this.handleDelete}>Delete</button>
    } else {
      deleteButton = '';
    }
    return <div className="tweet">
             <div className='tweet-header'>
               <a href={"/" + this.props.username}>
                 <span className="display-name">{this.props.displayName}</span>
                 <span className="user-name">@{this.props.username}</span>
               </a>
             </div>
             <div className="tweet-body">{linkifyHashtags(this.props.body)}</div>
             <div className="tweet-footer">
               {deleteButton}
             </div>
           </div>
  }
}

function linkifyHashtags(tweetBody) {
  let content = [];
  tweetBody.split('#').forEach((fragment, idx) => {
    if(fragment.length == 0) return;
    if(idx === 0) {
      content.push(<span>{fragment}</span>);
      return;
    }

    let word = fragment.split(/[ \n]/)[0];
    let encodedWord = encodeURIComponent('#' + word);
    let link = <a href={"/tweets/search?query=" + encodedWord}>#{word}</a>
    let rest = <span>{fragment.slice(word.length, fragment.length)}</span>;
    content.push(link, rest);
  });
  return content;
}
