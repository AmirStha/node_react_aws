import React, { Component } from "react";
import { Provider } from "react-redux";
import store from '../../utils/store';

import { Route, Switch } from 'react-router';
import { MemoryRouter,BrowserRouter } from 'react-router-dom';

import Home from '../Home'

class App extends Component {
  constructor() {
    super();
    this.state = {
    };
  }
  
  render() {
    return (
      <Provider store={store}>
        <BrowserRouter>
          <Switch>
              <Route 
                exact 
                path="/" 
                render={(props) => <Home {...props} companyName={'Bottle'} />}
              />
          </Switch>
        </BrowserRouter>
      </Provider>

      
    );
  }
}
export default App;
