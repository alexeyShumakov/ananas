class UserSingle extends React.Component {
  setUser(event) {
    event.preventDefault();
    let user = this.props.user;
    this.props.setUser(user);
  }

  render () {
    let user = this.props.user;
    return(
      <li>
        <a href="#" onClick={this.setUser.bind(this)} >
          {user.id}={user.email}={user.username}={user.role}
        </a>
      </li>
    );
  }
}

