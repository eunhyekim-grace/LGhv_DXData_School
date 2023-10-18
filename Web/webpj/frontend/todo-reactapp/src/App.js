import logo from './logo.svg';
import './App.css';

import React from 'react';
import Todo from './Todo';
import AddTodo from './AddTodo';

import{call} from './service/APIService'
import {Paper, List, Container} from "@material-ui/core";

class App extends React.Component{
  constructor(props){
    super(props);
    //여러 개의
    this.state = {items:[]};
  }
  
  //component가 메모리 할달을 한 후 출력하기 전에 호출되는 method
  componentDidMount(){
    //data를 가져오는 api 요청
    call('/todo/',"GET",null).then((response) => this.setState({items:response.list}))
  }

  //data 추가를 위한 함수
  //item 1개를 받아서 items에 저장하는 함수
  add = (item) => {
    item.userid = 'grace';
    call('/todo/',"POST",item).then((response) => this.setState({items:response.list}))
    // //기존 itmes를 thisItems에 복제
    // const thisItems = this.state.items;

    // //추가 할 item을 생성
    // item.id = "ID-" + thisItems.length;
    // item.done = false;

    // //복제본에 데이터 추가
    // thisItems.push(item);

    // //items에 복제본 추가 
    // //react 는 props 나 state가 변경되면 component를 자동 재출력함
    // this.setState({items:thisItems});
  }

  //data를 삭제하는 함수
  delete = (item) =>{
    item.userid = 'grace';
    call('/todo/',"DELETE",item).then((response) => this.setState({items:response.list}))
    // const thisItems = this.state.items;
    // //thisItems에서 item 삭제하기, id-> 구별 속성
    // const newItems = thisItems.filter((e) => e.id !== item.id);
    // //state를 변경해서 data 재출력
    // this.setState({items:newItems}, () => {
    //   console.log(item.id + "가 제거 되었습니다")
    // });
  }

  //data 수정하는 함수
  update = (item) => {
    item.userid = 'grace';
    call('/todo/', "PUT", item)
    .then((response) => this.setState({items:response.list}))
  }

  render(){
    
    var todoItems = this.state.items.length > 0 && (
      <Paper style={{margin : 16}}>
        <List>
          {this.state.items.map((item,idx) => (
            <Todo item = {item} key ={item.id} delete={this.delete} update = {this.update} />
          ))}
        </List>
      </Paper>
    );
    return(
      <div className='App'>
        <Container maxWidth="md">
          <AddTodo add = {this.add} />
          {todoItems}
        </Container>
      </div>
    )
  }
}

export default App;
