class UserSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = { text: '', users: [], user: null };
  }
  handleChange(event) {
    let keyword = event.target.value;
    let _this = this;

    this.setState((prevState) => {
      let newState = prevState;
      newState.text = keyword;
      newState.user = null;
      return newState;
    });

    $.get('/users/search', {keyword: keyword}).then(
      (data) => {
        this.setState((prevState) => {
          let newState = prevState;
          newState.users = data.users;
          return newState;
        });

      },
      (errors) => {
        console.log(errors);
      }
    )
  }

  setUser(user) {
    this.setState((prevState) => {
      let newState = prevState;
      newState.user = user;
      newState.users = [];
      newState.text = '';
      return newState;
    });
  }
  render () {
    let users = this.state.users;
    let user = this.state.user;
    let userForm;
    if (user) {
      userForm = <UserForm user={user} />;
    }
    if (users.length > 0 ) {
      users =
          users.map(user => {
            return(
              <UserSingle key={user.id} setUser={this.setUser.bind(this)} user={user} />
            );
          });
      users =
        <ul className='dropdown-menu'>
          {users}
        </ul>
    } else {
      users = null;
    }
    return(
      <div>
        <h3>Изменить данные пользователя</h3>
        <form className="form dropdown post-search" role="search">
          <div className="form-group">
            <input
              value={this.state.text}
              onChange={this.handleChange.bind(this)}
              type="text"
              className="form-control"
              placeholder="Search"/>
          </div>
          {users}
        </form>

        <hr/>
        {userForm}
      </div>
    );
  }
}

