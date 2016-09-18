import React from 'react';
import { Link } from 'react-router';
import Home from './Home';

const App = ({ children }) => (
  <div>
    <header>
      <Link to="/">Home</Link>
      <Link to="/about">About</Link>
      <Link to="/pattern">Pattern</Link>
    </header>
    <section>
      {children || <Home />}
    </section>
  </div>
);

App.propTypes = { children: React.PropTypes.object };

export default App;
