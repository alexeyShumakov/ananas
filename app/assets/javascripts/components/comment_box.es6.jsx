class CommentBox extends React.Component {

  fetchComments() {
    let _this = this;
    let url = this.props.url;
    $.get(url).then(
      (comments) => {
        _this.setState(comments);
      },
      (error) => {
        console.log(error);
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

  constructor(props) {
    super(props);
    this.state = { comments: [] };
    this.fetchComments();
  }
  render () {
    let destroyComment = this.destroyComment.bind(this);
    let updateComment = this.updateComment.bind(this);
    return (
      <div>
        <CommentForm />
        <CommentList data={this.state.comments}
          destroyComment={destroyComment}
          updateComment={updateComment}
        />
      </div>
    );
  }
}

