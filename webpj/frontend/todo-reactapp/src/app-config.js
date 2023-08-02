let backendHost;

//이전에 IE와 다른 browser들이 javascript에서 BOM(Browser Object Model)이 달라서 
//존재하는 값을 대입하기 위해서 사용하던 문법(Cross Browsing)
//이를 해결하기 위해서 등장했던 것이 jquery
const hostname = 
    window && window.location && window.location.hostname;

if(hostname === 'localhost'){
    backendHost = 'http://localhost:8000'
}

//백틱을 이용해서 변수의 내용을 문자열로 출력
export const API_BASE_URL = `${backendHost}`