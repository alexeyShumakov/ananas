class CommentList extends React.Component {
  render () {
    let _this = this;
    let comments = this.props.data.map(comment => {
      return(
        <Comment
          destroyComment={_this.props.destroyComment}
          updateComment={_this.props.updateComment}
          url={comment.url}
          canEdit={comment.canEdit}
          avatar={comment.avatar}
          author={comment.author}
          key={comment.id} >
          {comment.body}
        </Comment>
      );
    });
    return (
      <div>
        {comments}
      </div>
    );
  }
}

