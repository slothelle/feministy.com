import React from 'react'
import ReactDOM from 'react-dom'

let data = [
  {
    name: 'very pdx hat',
    gauge: 'this is a placeholder',
    description: 'Look, another placeholder!',
    thumbnails: [
      'http://images4-b.ravelrycache.com/uploads/feministy/274632786/very-pdx-1_small_best_fit.jpg',
      'http://images4-e.ravelrycache.com/uploads/feministy/293479459/IMG_7190_small_best_fit.jpg',
      'http://images4-e.ravelrycache.com/uploads/feministy/293479461/IMG_7189_small_best_fit.jpg',
      'http://images4-e.ravelrycache.com/uploads/globallooping/319141870/IMG_8496_small_best_fit.JPG'
    ]
  },
  {
    name: 'winter sea'
  }
]

class Pattern extends React.Component {
  render() {
    console.log("rendered")
    let patternNodes = this.props.data.map(pattern => {
      return (
          <div className="patternInfo" key={pattern.name}>
            <h1>Pattern</h1>
            <h2>{pattern.name}</h2>
          </div>
        )
    })
    return (
      <div className="patternContainer">
        {patternNodes}
      </div>
    )
  }
}

Pattern.propTypes = {
  data: React.PropTypes.array.isRequired
}

ReactDOM.render(
  <Pattern data={data} />,
  document.getElementById('content')
)

export default Pattern
