class PictureUploader extends React.Component {
  constructor(props) {
    super(props);
    this.state = {url: null};
  }

  handleChange(event) {
    let _this = this;
    let formData = new FormData();
    formData.append('image', event.target.files[0]);
    $.ajax({
      url: '/pictures',
      type: 'post',
      data: formData,
      processData: false,
      contentType: false
    }).then(
      (data) => {
        _this.setState({url: data.picture.imageUrl});
      }, (errors) => {
        alert('Что то пошло не так!');
      }
    );
  }
  render () {
    let urlBox;
    if (this.state.url) {
      urlBox = 
        <div>
          <hr/>
          <p>
            <b>Путь к вашей картинке:</b> {this.state.url}
          </p>
            Как пользоваться? вставьте в ваш пост: ![image]({this.state.url})
        </div>
    }
    return(
      <div className="panel panel-default">
        <div className="panel-heading">Загрузить картинку</div>
        <div className="panel-body">
          <input type='file' onChange={this.handleChange.bind(this)}/>
          {urlBox}
        </div>
      </div>
    );
  }
}

