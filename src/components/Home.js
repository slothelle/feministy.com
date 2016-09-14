import React from 'react';

const Home = () => (
  <div>
    <h2>What is a Gemfile?</h2>
    <p>A Gemfile is a special file in Ruby that allows you to declare, among other things:</p>
    <ul>
      <li>The Ruby version for your project</li>
      <li>A source for your dependencies (aka Ruby Gems)</li>
      <li>What version you're using for each dependency</li>
    </ul>

    <h2>What is a Ruby Gem?</h2>

    <p>A gem is nothing more than a bunch of files (usually Ruby, but sometimes other languages) grouped together to provide functionality. You could also call a gem a library!</p>

    <p>Some examples of well know Ruby gems include:</p>

    <ul>
      <li>Rails, a web framework</li>
      <li>Bundler, a tool used to create gems and manage Gemfiles</li>
    </ul>

    <p>(yes, it's very meta - a Ruby gem is used to manage Ruby gems!)</p>
  </div>
);

export default Home;

