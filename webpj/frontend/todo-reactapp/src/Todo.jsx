//react.js 파일에서 export한 객체를 React로 받아서 사용
//{이름} 의 경우 - export한 객체에서 이름에 해당하는 것만 받아서 사용
import React from 'react';

import {
    ListItem,
    ListItemText,
    InputBase,
    Checkbox,
    ListItemSecondaryAction,
    IconButton
}from "@material-ui/core"
//material이 들어가면 google의 flat design -> 2D

//icon 가져오기
import DeleteOutlined from "@material-ui/icons/DeleteOutlineOutlined";

class Todo extends React.Component{
    constructor(props){
        super(props)
        //props는 읽기 전용이라서 수정을 하고자 하는 경우 state에 복사해서 사용해야 함
        this.state = {item:props.item, readOnly:true} //states는 instance 변수, props는 넘겨 주는 애 
        this.delete = props.delete
        this.update = props.update
    }

    //event가 발생하면 readOnly의 값을 false로 수정
    offreadOnlyMode = (e) => {
        //state의 값을 직접 변경
        this.setState({readOnly:false});
    }

    //Enter를 눌렀을 때 동작하는 method
    enterKeyEventHandler = (e) => {
        if(e.key === 'Enter'){
            this.setState({readOnly:true});
            //data 수정
            this.update(this.state.item);
        }
    }

    //input의 내용을 변경했을 때 호출될 method
    editEventHandler = (e) =>{
        const thisItem = this.state.item;
        thisItem.title = e.target.value;
        this.setState({item:thisItem});
        
        this.update(this.state.item);
    }

    //checkbox 눌렀을 때 호출되는 method
    checkboxEventHandler = (e) => {
        const thisItem = this.state.item;
        thisItem.done = !thisItem.done;
        this.setState = ({item:this.item})

        this.update(this.state.item);
    }

    //삭제 아이콘을 눌렀을 때 호출될 함수
    deleteEventHandler = (e) =>{
        this.delete(this.state.item);
    }

    render(){
        //method 안에서 instance 변수를 사용하고 싶으면 항상 this를 사용해서 instance속성임을 알려줘야 함
        // this.state = {이름:초기값, 이름:초기값, ... }
        return(
            <ListItem>
                <Checkbox checked = {this.state.item.done} onChange={this.checkboxEventHandler}/>
                <ListItemText>
                    <InputBase 
                        inputProps = {{'aria-label':'naked', readOnly:this.state.readOnly}}
                        type = 'text'
                        id = {this.state.item.id}
                        name = {this.state.item.id}
                        value = {this.state.item.title} 
                        multiline=  {true}
                        fullWidth = {true} 
                        onClick={this.offreadOnlyMode}
                        onKeyPress={this.enterKeyEventHandler}
                        onChange={this.editEventHandler}/>
                </ListItemText>

                <ListItemSecondaryAction>
                    <IconButton aria-label='Delete Todo'
                        onClick={this.deleteEventHandler}>
                        <DeleteOutlined />
                    </IconButton>
                </ListItemSecondaryAction>
            </ListItem>
             // 글자 뒤에 button 위치 하게 설정, aria-label은 실제 화면 출력 X
        )
    }
}//name - 서버 전송 이름, value - 초기값, id - 내부에서 구별하기 위해 사용하는 값

export default Todo;