class Mailing extends React.Component {
  constructor(props) {
    super(props);
    this.state = {weeklyMailing: props.weekly_mailing}
  }

  toggleMailing(e) {
    e.preventDefault();
    let _this = this;
    let newWeeklyMailing = !this.state.weeklyMailing
    $.ajax({
      url: '/users/profile',
      type: 'patch',
      data: {user: {weekly_mailing: newWeeklyMailing}}
    }).then( data => {
      _this.setState({weeklyMailing: newWeeklyMailing});
    })
  }
  render () {
    let body;
    if (this.state.weeklyMailing) {
      body =
        <div>
          подписан -/- <a href='#' onClick={this.toggleMailing.bind(this)}>отписаться</a>
        </div>
    } else {
      body =
        <div>
          не подписан -/- <a href='#' onClick={this.toggleMailing.bind(this)}>подписаться</a>
        </div>
    }
    return(
      <div>
        {body}
      </div>
    );
  }
}

