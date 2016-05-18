class UserAvatarWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = { avatarUrl: props.avatarUrl }
  }


  handleChange(event) {
    let file = event.target.files[0];
    if (file) {
      let _this = this;
      let formData = new FormData();
      formData.append('user[avatar]', event.target.files[0]);
      $.ajax({
        url: '/users/profile',
        type: 'patch',
        data: formData,
        processData: false,
        contentType: false
      }).then(
        (data) => {
          _this.setState({avatarUrl: data.user.avatarMediumUrl});
        }, (errors) => {
          alert('Что то пошло не так!');
        }
      );
    }
  }
  render () {
    return(
      <div>
        <img src={this.state.avatarUrl}/>
        <h4 className='text-center'>Изменить аватарку</h4>
        <input type='file' onChange={this.handleChange.bind(this)}/>
        <hr/>
      </div>
    );
  }
}

