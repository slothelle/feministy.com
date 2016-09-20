import React from 'react'
import ReactDOM from 'react-dom'

const data = [{ name: 'hello panda' }]

class Pattern extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      data: data
    }
  }

  render() {
    console.log(this.state.data)
    console.log(this.state.hello)
    let patternNodes = this.state.data.map(pattern => {
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
  data: React.PropTypes.array
}

ReactDOM.render(
  <Pattern />,
  document.getElementById('content')
)

export default Pattern
