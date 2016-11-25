class SearchBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(ev) {
    this.setState({value: ev.target.value});
  }

  handleSubmit(ev) {
    window.location = '/tweets/search?query=' + encodeURIComponent(this.state.value);
  }

  render() {
    return <div className="search">
             <span>Search: </span>
             <input type="text" value={this.state.value} onChange={this.handleChange} />
             <button type="submit" onClick={this.handleSubmit}>Submit</button>
           </div>
  }
}
