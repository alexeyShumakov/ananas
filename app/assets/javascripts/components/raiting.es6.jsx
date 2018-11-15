class Raiting extends React.Component{
  fetchRecords() {
    let _this = this;
    let url = this.props.url;
    $.get(url).then(
      (records) => {
        _this.setState({ records: records.posts });
      },
      (error) => {
      }
    )
  }



componentDidUpdate(nextProps) {
  console.log('Will updated');
	this.props.items = nextProps.items;
  console.log(nextProps);
	this.fetchRecords();
}

  constructor(props) {
    super(props);
    this.state = { records: [] };
		this.fetchRecords();
  }
  render(){
      return(
      <div>
      <RaitingTable data={this.state.records} />
      </div>
            )
  }
}
