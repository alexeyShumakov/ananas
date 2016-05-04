class PostPreview extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: ''};
  }

  updateMd() {
    let _this = this;
    let bodyValue = $('#post_body').val();
    $.get('/posts/md_preview', { text: bodyValue }).then(
      (mdText) => {
        _this.setState({text: mdText.text});
      }
    )
  }

  rawMd() {
    return { __html: this.state.text };
  }
  render () {
    return(
      <div>
        <button className='pull-right btn btn-primary' onClick={this.updateMd.bind(this)}>Показать/обновить</button>
        <h2>Предпросмотр(только 'body')</h2>
        <hr/>
        <div dangerouslySetInnerHTML={this.rawMd()} className='post__preview'></div>
      </div>
    );
  }
}

