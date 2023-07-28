import logo from './logo.svg';
import './App.css';
import MyComponent from './MyComponent';
import Sample from './sample';
import EventComponent from './EventComponent';

function App() {
  
  return (
    <>
      <MyComponent album = 'genesis' />
      <Sample album = 'exodus'>sample data</Sample>
      <EventComponent />
    </>
  );
}

export default App;
