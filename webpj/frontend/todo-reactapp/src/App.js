import logo from './logo.svg';
import './App.css';

import React from 'react';
import Todo from './Todo';

class App extends React.Component{
  constructor(props){
    super(props);
    //하나의 객체를 생성해서 state에 item 이라는 이름으로 저장
    this.state = {item: {id:0, title:"Hello React", done:true}};
  }
  render(){
    return(
      <div className='App'>
        <Todo item={this.state.item} />
      </div>
    )
  }
}

export default App;
