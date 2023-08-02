import React from "react";

import {TextField, Paper, Button, Grid} from "@material-ui/core";

//한 줄의 text를 입력 받아서 버튼을 누르면 추가하는 component
class AddTodo extends React.Component{
    constructor(props){
        super(props);
        //입력 받은 내용을 저장할 state 생성
        this.state = {item:{title:""}}

        //넘겨준 데이터를 변수에 대입
        this.add = props.add
    }

    //입력 내용이 변경될 때 title을 수정하는 method
    onInputChange = (e) => {
        //item 속성 복제
        const thisItem = this.state.item;
        //복제된 객체의 title 값을 입력한 내용으로 수정
        thisItem.title = e.target.value;
        //복제된 개체를 다시 item으로 복사
        this.setState({item:thisItem});
    }

    // + 버튼 누를 때 호출되는 method
    onButtonClick = (e) => {
        this.add(this.state.item); //data 추가
        //title을 clear - 입력 상자도 clear
        this.setState({item:{title:""}});
    }

    //Enter를 눌렀을 때 호출되는 method
    enterKeyHandler = (e) =>{
        //Enter를 누르면 버튼을 누른 것과 동일한 효과
        if(e.key === 'Enter'){
            this.onButtonClick();
        }
    }

    render(){
        return(
            //외부 여백 - margin, paper의 내부 여백 - padding
            //xs, md는 사이즈 의미, 전체가 16
            <Paper style={{margin : 16, padding: 16}}> 
                <Grid xs={11} md={11} item style={{padding:16}}>
                    <TextField placeholder="제목을 입력" fullWidth

                            value = {this.state.item.title}
                            onChange={this.onInputChange}
                            onKeyPress={this.enterKeyHandler}/>
                </Grid>
                <Grid xs={1} md={1} item>
                    <Button fullWidth color="secondary" variant="outlined"
                            onClick={this.onButtonClick}>
                        +
                    </Button>
                </Grid>
            </Paper>
        )
    }
}

export default AddTodo;