class UserForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      id: props.user.id,
      email: props.user.email,
      username: props.user.username,
      role: props.user.role,
      roles: props.user.roles,
      errors: [],
      successMessage: null
    };
  }

  updateField(field, value) {
    this.setState(
      (prevState) => {
        let newState = prevState;
        newState[field] = value;
        newState.successMessage = null;
        return newState;
      }
    );
  }
  updateUser() {
    let _this = this;
    let params = {
      user: {
        username: this.state.username,
        email: this.state.email,
        role: this.state.role
      }
    };
    $.ajax({
      url: `/users/${this.state.id}`,
      type: 'patch',
      data: params
    }).then(
      (data) => {
        _this.setState(
          (prevState) => {
            let newState = prevState;
            newState.successMessage = 'Пользователь успешно обновлен!';
            return newState;
          }
        );
      },
      (data) => {
        _this.setState(
          (prevState) => {
            let newState = prevState;
            newState.errors = data.responseJSON;
            return newState;
          }
        );
      }
    );
  }
  updateRole(event) {
    this.updateField('role', event.target.value );
  }
  render () {
    let successMessage = this.state.successMessage;
    let userRole = this.state.role;

    let options = this.state.roles.map(role => {
      return( <option key={role.value} value={role.name}> {role.name} </option>);
    });
    if (successMessage) {
      successMessage = <b> {successMessage} </b>;
    }
    return(
      <div>
        <form className='form-horizontal'>
          <UserFormInput
            errors={this.state.errors['email']}
            label='Email'
            value={this.state.email}
            type='text'
            field='email'
            updateField={this.updateField.bind(this)}
          />

          <UserFormInput
            errors={this.state.errors['username']}
            label='User name'
            value={this.state.username}
            type='text'
            field='username'
            updateField={this.updateField.bind(this)}
          />

          <div className="form-group">
            <label className="control-label col-md-2">user role</label>
            <div className="col-md-10">
              <select value={this.state.role} className='form-control' onChange={this.updateRole.bind(this)} >
                { options }
              </select>
            </div>
          </div>

          <div className="form-group">
            <div className="col-sm-offset-2 col-sm-10">
              <div className="btn btn-primary" onClick={this.updateUser.bind(this)}>change user params</div>
              {successMessage}
            </div>
          </div>
        </form>
      </div>
    );
  }
}

