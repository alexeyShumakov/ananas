class PostFavorites extends React.Component {
  constructor(props) {
    super(props);
    let post = props.post;
    this.state = { 
      favoritesCount: post.favoritesCount,
      hasFavorite: post.hasFavorite
    };
  }

  updateFavorite() {
    let _this = this;
    $.post('/favorites', {favorite: { post_id: this.props.post.id}}).then(
      (data) => {
        _this.setState(data.post);
      },
      (err) => {
        console.log(err);
      }
    )
  }
  render () {
    let hasFavorite = this.state.hasFavorite;
    return (
      <div>
        <button className="btn btn-default" onClick={this.updateFavorite.bind(this)}>
          <span className={`glyphicon glyphicon-star${hasFavorite ? '' : '-empty'}`}></span> {this.state.favoritesCount}
        </button>
      </div>
    );
  }
}

