class History extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isShow: false, isMd: false }
  }

  toggleIsMd() {
    this.setState((prevState) => {
      let newState = prevState;
      newState.isMd = !prevState.isMd;
      return newState;
    })
  }

  toggleIsShow() {
    this.setState((prevState) => {
      let newState = prevState;
      newState.isShow = !prevState.isShow;
      return newState;
    })
  }
  rawMd() {
    return { __html: this.props.history.historyMd };
  }
  render () {
    let body;
    let text;
    if (this.state.isMd) {
      text =
        <div className='form-group'>
          <textarea cols="30" rows="10" className='form-control' defaultValue={this.props.history.history}></textarea>
        </div>
    } else {
      text =
        <div dangerouslySetInnerHTML={this.rawMd()}></div>
    }
    if (this.state.isShow) {
      body =
        <div className="panel panel-default">
          <div className="panel-heading">
            {this.props.history.title}
            <hr/>
            <button className="btn btn-default" onClick={this.toggleIsMd.bind(this)}>{ this.state.isMd ? 'скрыть разметку' : 'показать разметку'}</button>
          </div>
          <div className="panel-body">
            {text}
          </div>
          <div className='panel-footer'>
            <a href={`/histories/${this.props.history.id}/edit`}>Изменить историю</a> |
            <a href={`/histories/${this.props.history.id}`}>Показать историю</a>
          </div>
        </div>
    }

    return(
      <div className='history' >
        <a href={`/histories/${this.props.history.id}`}>{this.props.history.title}</a>
        <button className="btn btn-default pull-right" onClick={this.toggleIsShow.bind(this)}>{ this.state.isShow ? 'скрыть историю' : 'показать историю'}</button>
        <div className="clearfix"></div>
        {body}
        <hr/>
      </div>
    );
  }
}

