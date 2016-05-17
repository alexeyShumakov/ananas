class Comment extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isEdit: false, text: props.children, error: null };
  }

  deleteComment() {
    this.props.destroyComment(this.props.url);
  }

  updateComment() {
    let _this = this;
    let newComment = this.props.updateComment(this.props.url, this.state.text);
    newComment.then(
      () => {
      _this.toggleEdit();
      }, (errors) => {
        this.setState((prevState) => {
          let newState = prevState;
          newState.error = errors.responseJSON.body[0];
          return newState;
        });
      }
    );
  }

  toggleEdit() {
    this.setState((prevState) => {
      let newState = prevState;
      newState.isEdit = !prevState.isEdit;
      newState.error = null;
      return newState;
    });
  }

  updateText(event) {
    this.setState((prevState) => {
      let newState = prevState;
      newState.text = event.target.value;
      return newState;
    });
  }

  updateLike() {
    let commentId = this.props.id;
    this.props.updateLike(commentId);
  }

  date() {
    let date = new Date(this.props.createdAt);
    return date.toLocaleString('ru', {
      year: "numeric",
      month: "long",
      day: "numeric"
    });
  }
  render () {
    let hasLiked = this.props.hasLiked;
    let editButtons;
    let mainComment;
    let error;
    let likeButton =
      <div>
        <span className={`icon-box__like${hasLiked ? '' : '-empty'}`} onClick={this.updateLike.bind(this)}></span>{this.props.likesCount}
      </div>

    if (this.state.error) {
      error = <div> {this.state.error} </div>
    }
    if (this.props.canEdit) {
      editButtons =
        <div className="icon-box pull-right">
          <span className="icon-box__delete" onClick={this.deleteComment.bind(this)}></span>
          <span className="icon-box__edit" onClick={this.toggleEdit.bind(this)}></span>
          <span className={`icon-box__like${hasLiked ? '' : '-empty'}`} onClick={this.updateLike.bind(this)}></span> {this.props.likesCount}
        </div>
    } else {
      editButtons =
        <div className="icon-box pull-right">
          <span className={`icon-box__like${hasLiked ? '' : '-empty'}`} onClick={this.updateLike.bind(this)}></span> {this.props.likesCount}
        </div>
    }

    if (this.state.isEdit) {
      mainComment =
        <div>
          <div className="form-group">
            <textarea className="text form-control" value={this.state.text} onChange={this.updateText.bind(this)}></textarea>
          </div>
          {error}
          <button className="btn btn-primary" onClick={this.updateComment.bind(this)}>Изменить</button>
        </div>

    } else {
      mainComment = <div>{this.props.children}</div>
    }
    return (
      <div className='media'>

        <div className="media-left">
          <a href="#">
            <img src={this.props.avatar} alt=""/>
          </a>
        </div>

        <div className="media-body">
          {editButtons}
          <h4 className="media-heading">
            {this.props.author}, { this.date() }
          </h4>
          {mainComment}
        </div>

      </div>
    );
  }
}

