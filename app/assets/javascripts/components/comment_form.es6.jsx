class CommentForm extends React.Component {

  constructor(props) {
    super(props);
    this.state = { text: '', error: null };
  }

  updateText(event) {
    this.setState((prevState) => {
      let newState = prevState;
      newState.text = event.target.value;
      return newState;
    });
  }
  createComment() {
    let _this = this;
    let newComment = this.props.createComment(this.state.text);
    newComment.then(
      () => {
        this.setState((prevState) => {
          let newState = prevState;
          newState.error = null;
          newState.text = '';
          return newState;
        });
      }, (errors) => {
        this.setState((prevState) => {
          let newState = prevState;
          newState.error = errors.responseJSON.body[0];
          return newState;
        });
      }
    );

  }
  render () {
    let form;
    let error;
    if (this.state.error) {
      error = <div> {this.state.error} </div>
    }

    if (this.props.isSignedIn) {
      form =
        <div>
          <div className="form-group text">
            <label className="text control-label">Написать комментарий</label>
            <textarea className="text form-control" value={this.state.text} onChange={this.updateText.bind(this)}></textarea>
          </div>
          {error}
          <button className="btn btn-primary" onClick={this.createComment.bind(this)}>Написать</button>
        </div>
    } else {
      form =
        <div className="alert alert-info">
          <a href="/users/sign_in">Войдите</a> или <a href="/users/sign_up">Зарегистрируйтесь</a>, чтобы оставить комментарий.
        </div>
    }
    return (
      <div>
        {form}
      </div>
    );
  }
}

