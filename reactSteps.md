# React I 

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
* inside Hello.js after h2 and inside className=Hello you can add this 
```javascript
  <h1 onMouseLeave={() => {console.log('Mouse Left!')}}> jjjj </h1>
```




