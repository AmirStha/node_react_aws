import React, { Component } from 'react';
import PropTypes from 'prop-types';

import './style.css'
class Home extends Component {
  render() {
    const { companyName } = this.props
    return (
      <div className="container">
        <h1 className="">You must be great! Welcome to {companyName} </h1>
      </div>
    );
  }
}

export default Home;

Home.propTypes = {
  companyName: PropTypes.string
}
