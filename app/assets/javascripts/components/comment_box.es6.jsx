class CommentBox extends React.Component {

  fetchComments() {
    let _this = this;
    let url = this.props.url;
    $.get(url).then(
      (comments) => {
        _this.setState(comments);
      },
      (error) => {
      }
    )
  }

  destroyComment(url) {
    let _this = this;
    let comments = this.state.comments;
    let commentId;
    $.ajax({url: url, type:'delete'}).then(
      () => {
        comments.find((element, index, array) => {
          if (element.url === url) { commentId = index; }
        });
        comments.splice(commentId, 1);
        _this.setState((prevState) => {
          let newState = prevState;
          newState.comments = comments;
          return newState;
        });
      }
    )
  }

  updateComment(url, text) {
    let _this = this;
    let comments = this.state.comments;
    return $.ajax({
      url: url,
      type:'patch',
      data: { body: text }
    }).then(
      (data) => {
        comments.find((element, index, array) => {
          if (element.url === url) { element.body = data.comment.body; }
        });
        _this.setState((prevState) => {
          let newState = prevState;
          newState.comments = comments;
          return newState;
        });
      }, (err) => {
       return err;
      }
    )
  }

  createComment(text) {
    let _this = this;
    let comments = this.state.comments;
    return $.ajax({
      url: '/comments',
      type:'post',
      data: { comment: {
        body: text,
        commentable_id: _this.props.commentable_id,
        commentable_type: _this.props.commentable_type
        }
      }
    }).then(
      (data) => {
        _this.setState((prevState) => {
          let newState = prevState;
          newState.comments.unshift(data.comment);
          return newState;
        });
      }, (err) => {
       return err;
      }
    )
  }

  updateLike(commentId) {
    let _this = this;
    let comments = this.state.comments;
    $.ajax({
      url: '/likes',
      type: 'post',
      data: {like: {comment_id: commentId}},
    }).then(
      (data) => {
        comments.find((element, index, array) => {
          if (element.url === data.comment.url) {
            element.likesCount = data.comment.likesCount;
            element.hasLiked = data.comment.hasLiked;
          }
        });
        _this.setState((prevState) => {
          let newState = prevState;
          newState.comments = comments;
          return newState;
        });
      }, (err) => {
       return err;
      }
    )
  }
  constructor(props) {
    super(props);
    this.state = { comments: [] };
    this.fetchComments();
  }
  render () {
    let destroyComment = this.destroyComment.bind(this);
    let updateComment = this.updateComment.bind(this);
    let createComment = this.createComment.bind(this);
    let updateLike = this.updateLike.bind(this);
    return (
      <div>
        <CommentForm isSignedIn={this.props.isSignedIn} createComment={createComment} />
        <hr/>
        <CommentList data={this.state.comments}
          destroyComment={destroyComment}
          updateComment={updateComment}
          updateLike={updateLike}
        />
      </div>
    );
  }
}

