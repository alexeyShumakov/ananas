class CommentList extends React.Component {
  render () {
    let _this = this;
    let comments = this.props.data.map(comment => {
      return(
        <Comment
          id={comment.id}
          destroyComment={_this.props.destroyComment}
          updateComment={_this.props.updateComment}
          updateLike={_this.props.updateLike}
          url={comment.url}
          canEdit={comment.canEdit}
          avatar={comment.avatar}
          author={comment.author}
          hasLiked={comment.hasLiked}
          likesCount={comment.likesCount}
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

