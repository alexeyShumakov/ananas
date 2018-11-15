class RaitingTable extends React.Component {
  render () {
    console.log('Raiting Table. Data is:');
    console.log(this.props.data);
    let records = this.props.data.map(record => {
      return(
        <RaitingRecord
          url={record.url}
          raiting={record.raiting}
          username={record.username}
          key={record.id}>
        </RaitingRecord>
      );
    });
    return (
      <div>
        {records}
      </div>
    );
  }
}
