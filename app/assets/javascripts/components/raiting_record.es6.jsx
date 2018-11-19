class RaitingRecord extends React.Component {
  constructor(props) {
    super(props);
  }

  render () {
    return (
      <div className='text-center'>
      <hr />
        <p><a href={this.props.url}>{this.props.username}</a></p> 
                  <div className='icon-box center-block'>
                      <span className="icon-box__crown"></span> {this.props.raiting}
              		</div>
                </div>
    );
  }
}
