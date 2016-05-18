class PostSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: '', posts: []};
  }
  handleChange(event) {
    let keyword = event.target.value;
    let _this = this;

    this.setState((prevState) => {
      let newState = prevState;
      newState.text = keyword;
      return newState;
    });

    $.get('/posts/search', {keyword: keyword}).then(
      (data) => {
        this.setState((prevState) => {
          let newState = prevState;
          newState.posts = data.posts;
          return newState;
        });

      },
      (errors) => {
        console.log(errors);
      }
    )
  }
  render () {
    let posts = this.state.posts;
    if (posts.length > 0 ) {
      posts =
          posts.map(post => {
            return(
              <li key={post.id}>
                <a href={post.url} >
                  {post.impressions} <span className="glyphicon glyphicon-eye-open"></span> {post.title}
                </a>
              </li>
            );
          });
      posts =
        <ul className='dropdown-menu'>
          {posts}
        </ul>
    } else {
      posts = null;
    }
    return(
        <form className="navbar-form navbar-left dropdown post-search" role="search">
          <div className="form-group">
            <input
              value={this.state.text}
              onChange={this.handleChange.bind(this)}
              type="text"
              className="form-control"
              placeholder="Поиск"/>
          </div>
          {posts}
        </form>
    );
  }
}

