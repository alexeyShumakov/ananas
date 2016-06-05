class MdPreview extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: '', isLoading: false};
  }

  updateMd() {
    let _this = this;
    let elementId = this.props.element_id;
    let bodyValue = $(elementId).val();
    this.setState({isLoading: true})
    $.post('/posts/md_preview', { text: bodyValue }).then(
      (mdText) => {
        _this.setState({text: mdText.text, isLoading: false});
      }
    )
  }

  rawMd() {
    return { __html: this.state.text };
  }
  render () {
    let loadingIndicator;
    let isLoading = this.state.isLoading;
    if(isLoading) {
      loadingIndicator = ' loading...'
    }
    return(
      <div>
        <button className='pull-right btn btn-primary' onClick={this.updateMd.bind(this)} disabled={isLoading} >Показать/обновить {loadingIndicator}</button>
        <h2>Предпросмотр</h2>
        <hr/>
        <div dangerouslySetInnerHTML={this.rawMd()} className='post__preview'></div>
      </div>
    );
  }
}

