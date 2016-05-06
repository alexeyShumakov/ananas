class UserFormInput extends React.Component {
  handleChange(event) {
    let field = this.props.field;
    this.props.updateField(field, event.target.value);
  }
  render () {
    let field = this.props.field;
    let errors = this.props.errors;
    let hasErrors = errors && errors[field];
    if (hasErrors) {
      errors = errors[field].map(error => {
        hasErrors = true;
        return(<li>{error}</li>);
      });
    }
    return(
      <div className='form-group'>
        <label className='control-label col-md-2'>{this.props.label}</label>
        <div className="col-md-10">
          <input
            onChange={this.handleChange.bind(this)}
            type={this.props.type}
            value={this.props.value}
            className='form-control'/>
          <ul className='help-block list-unstyled'>
            {errors}
          </ul>
        </div>
      </div>
    );
  }
}

