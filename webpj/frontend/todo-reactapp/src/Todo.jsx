//react.js 파일에서 export한 객체를 React로 받아서 사용
//{이름} 의 경우 - export한 객체에서 이름에 해당하는 것만 받아서 사용
import React from 'react';

class Todo extends React.Component{
    constructor(props){
        super(props)
        //props는 읽기 전용이라서 수정을 하고자 하는 경우 state에 복사해서 사용해야 함
        this.state = {item:props.item}
    }

    render(){
        //method 안에서 instance 변수를 사용하고 싶으면 항상 this를 사용해서 instance속성임을 알려줘야 함
        // this.state = {이름:초기값, 이름:초기값, ... }
        return(
            <div className = 'Todo'>
                <input type='checkbox' 
                    id = {this.state.item.id} 
                    name = {this.state.item.name} 
                    value= {this.state.item.done} /> 
                <label id = {this.state.item.done}>{this.state.item.title}</label>
            </div>
        )
    }
}//name - 서버 전송 이름, value - 초기값, id - 내부에서 구별하기 위해 사용하는 값

export default Todo;