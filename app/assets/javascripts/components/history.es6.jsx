class History extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isShow: false, isMd: false, status: 'wait' }
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

  allowHistory() {
    let _this = this;
    $.ajax({
      url: `/histories/${this.props.history.id}.json`,
      type: 'patch',
      data: { history: {moderated: true}}
    }).then((data) => {
      _this.setState((prevState) => {
        let newState = prevState;
        newState.status = 'allow';
        newState.isShow = false;
        return newState;
      });
    },(data) => {
      console.log('bad!');
    });
  }

  destroyHistory() {
    let _this = this;
    $.ajax({
      url: `/histories/${this.props.history.id}.json`,
      type: 'delete',
      dataType: 'json'
    }).then((data) => {
      _this.setState((prevState) => {
        let newState = prevState;
        newState.status = 'destroy';
        newState.isShow = false;
        return newState;
      });
    },(data) => {
      console.log('bad!');
    })
  }

  rawMd() {
    return { __html: this.props.history.historyMd };
  }
  render () {
    let statusLabel;
    let body;
    let text;
    switch (this.state.status) {
      case 'wait':
        statusLabel = <span className="label label-primary">Ожидает</span>;
        break;
      case 'destroy':
        statusLabel = <span className="label label-danger">Удален</span>;
        break;
      case 'allow':
        statusLabel = <span className="label label-success">Одобрен</span>;
        break;
    }
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
        <div className="row history">
          <div className="col-md-12">
            <div className="panel panel-default">
              <div className="panel-heading">
                <div className="btn-toolbar">
                  <div className="btn-group">
                    <button className="btn btn-default btn-success" onClick={this.allowHistory.bind(this)}>
                      <span className="glyphicon glyphicon-ok"></span>
                    </button>
                    <a className="btn btn-default btn-info" href={`/histories/${this.props.history.id}/edit`}>
                      <span className="glyphicon glyphicon-pencil"></span>
                    </a>
                    <button className="btn btn-default btn-danger" onClick={this.destroyHistory.bind(this)}>
                      <span className="glyphicon glyphicon-remove"></span>
                    </button>
                  </div>

                  <div className="btn-group">
                    <button className="btn btn-default" onClick={this.toggleIsMd.bind(this)}>
                      { this.state.isMd ? 'скрыть разметку' : 'показать разметку'}
                    </button>
                  </div>
                </div>
              </div>
              <div className="panel-body">
                {text}
              </div>
            </div>
          </div>
        </div>
    }

    return(
      <div>
        <div className='row history' >
          <div className="col-md-4">
            <img className="img-circle" src={this.props.history.user.avatarSmallUrl}/>
            <b> {this.props.history.user.username} {statusLabel}</b>
          </div>
          <div className="col-md-4">
            <p>{this.props.history.title}</p>
          </div>
          <div className="col-md-4">
            <button className="btn btn-default" onClick={this.toggleIsShow.bind(this)}>{ this.state.isShow ? 'скрыть историю' : 'показать историю'}</button>
          </div>
        </div>
        <hr/>
        {body}
      </div>
    );
  }
}

