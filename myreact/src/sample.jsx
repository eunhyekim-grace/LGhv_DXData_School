function Sample(props){
    //Javascript의 구조 분해 할당
    //등호의 오른쪽 - 객체를 설정, 왼쪽 - 중괄호 안에 변수 설정 -> 변수 이름과 동일한 객체의 속성이 분해되서 대입됨
    const {album, children} = props;

    return(<div>2nd album {album}, tag 안의 내용: {children}</div>)
}
export default Sample;