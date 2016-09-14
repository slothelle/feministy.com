import React from 'react';
import { Link } from 'react-router';
import Home from './Home';

const App = ({ children }) => (
  <div>
    <header>
      <h1>How do Gemfiles even?</h1>
      <div>
        <Link to="/">Home</Link>
        <Link to="/about">About</Link>
      </div>
    </header>
    <section>
      {children || <Home />}
    </section>
  </div>
);

App.propTypes = { children: React.PropTypes.object };

export default App;
