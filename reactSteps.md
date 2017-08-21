# React 

```javascript
npm install -g create-react-app
create-react-app react-demo
cd react-demo
npm install 
```
* All index.js has at least one React.Render at first
```javascript
ReactDOM.render(<App />, document.getElementById('root'));
```
* React.Render has two parts first is  a component `<App />` and second is the actual dom `document.getElementById('root')` where they have to dump that component.
* We create a folder name components and create commponents there with capitalize name, then import all to `app.js`, and just call the component as below with one props 
```javascript
import Hello from './components/Hello';
<Hello name='Jon' />
```
components/Hello.js
```javascript
import React, { Component } from 'react';
class Hello extends Component
{
 render(){
   return (
     <div className="Hello">
        <h2> Hello {this.props.name} </h2>
    </div>
   );
 }
}
export default Hello;
```
* name can be an array on names then only change as 
```javascript
<Hello name={['amir','ali','hassan']} />
```
and inside Hello.js
```javascript
<h3> {this.props.name.map((cc) => <h4> {cc} </h4>)} </h3>
```
-------------
#### Bootstrap 
* Check React bootstrap components to have them easily in your code 
https://react-bootstrap.github.io/components.html
```javascript
 npm install --save bootstrap
```
inside index.js import so you have Bootstrap working in the whole app
```javascript
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
```
inside app.js to see it works! 
```javascript
<button type="button" className="btn btn-primary">Primary</button>
```
Also you can have simplest way in index.html in public folder
```javascript
 <Button bsStyle="primary">Primary</Button>
```
---------------
## Event 
* React has a list of defined `events`
* inside Hello.js after h2 and inside className=Hello you can add this 
```javascript
  <h1 onMouseOver={() => {console.log('Mouse Left!')}}> jjjj </h1>
```
* Having multiple call backs on one component. colorCycle is a function defined in that class 
```javascript
<h1 onClick={this.colorCycle}
      className='Hello2'
      onMouseOver={() => {console.log("Hover!"); this.setState({hovered: false})}}
  > dd
  </h1>
```
```javascript 
colorCycle(){
 console.log(this);
}
```
* to have access this from function, we need to bind this in constructor, so we define a constructor in class
```javascript
constructor (props) {
   super(props);
  this.colorCycle = this.colorCycle.bind(this)
}
```
* Now when we click it knows `this` 
-----------------
### Change dynamicly the state in a function
* in function we can set the state as 
```javascript
colorCycle() {
    console.log(this);
    this.setState({amir: props, ali: "DFD", cnt: 1});
  }
```
* but to have a counter and increament or decremnt it we need to define a function to setstate because state and props may update asychronously so we need like this 
```javascript
colorCycle() {
    console.log(this);
    this.setState((state , props) =>
    ({amir: props, ali: "DFD", cnt: state.cnt + 1}));
  }
```
* first arg is previous state and second is props.  Now property of cnt in state is incremeant 
------
### Style
* Define const style after render and add style tag after classNmae
```javascript
  const style = {borderRadius: type === 'circle' ? '99999999px' : '0px',width: '150px',height: '150px', backgroundColor:   COLORS[this.state.cnt]}
  return ( <div onClick={this.colorCycle} className='Shape' style={style} /> );
```
-------
# Form 
* Add a form in a file call greeting.js and return it 
```javascript
return (
      <div className='GuestBook'>
        <h1>Guest Book</h1>

        <div className='GuestBookEntries'>
          {this.renderEntries()}
        </div>

        <form onSubmit={this.addEntry}>
          <div>
            <label htmlFor='message'>Message</label> <br />
            <textarea id='message' name='message' />
          </div>

          <div>
            <label htmlFor='name'>Name</label> <br />
            <input id='name' name='name' />
          </div>

          <div>
            <input type='submit' value='submit' />
          </div>
        </form>
      </div>
    )
```
* To avoid null value for message add this to constructor `this.state = { message: "" };`
* Just need to define addEntry and renderEntries fucntions.
```javascript
addEntry(event){
  event.preventDefault();
  const {currentTarget} = event;
  const fData = new FormData(currentTarget);
  this.setState((state, props) =>({message: fData.get('message')}));
  }
```
* prevent defualt is necessary for avoiding submiting, then assign event into a formdata constant to be able to use get and etc methods. Then setState of message. Now to show it on page should just define a funciton to return state.message as below 
```javascript
renderEntries() {
  return(
   <h1> {this.state.message} </h1> 
   )
 }
```
-----------
* To have a list of all entries and not only last message, we need an stack memory. State has a stack memory array so we define `entries: []` in constructor and then contcat messages into it. Everytime `state.entries` property has an array which updated! 
```javascript
const {entries} = this.state;
this.setState({
      entries: entries.concat([{
        message: fData.get('message')
      }])
    });
```
* Then the rendersEntry is a map go through all entries
```javascript
 renderEntries() {
  return(
   <h1> {this.state.entries.map((entry, index) =>
     (<p>{entry.message} </p>))} </h1> )
    }
```
* Also we can wrap entry.message by styles and havign key index 
```javascript
   <div key={index} style={{backgroundColor: index % 2 ? 'White' : 'WhiteSmoke', padding: '5px'}}> 
      <p>{entry.message}</p>
    </div>
```
* Adding `key={index}` is neccessary 
--------
























