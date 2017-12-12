import React, { Component } from 'react';

import Hello from './components/Hello'


class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">

          <h2>Welcome to React</h2>
          <button type="button" className="btn btn-primary">Primary</button>
        
          <Hello now={['amir','ali','hassan']}/>
        </div>

      </div>
    );
  }
}

export default App;
