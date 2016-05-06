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
          <b>id:</b> {user.id} <b>email:</b> {user.email ? user.email : '~~~~'} <b>username:</b> {user.username} <b>role:</b> {user.role}
        </a>
      </li>
    );
  }
}

