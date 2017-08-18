import React, { Component } from 'react';


class Hello extends Component
{
  // constructor (props) {
  //   super(props);
  //
  //   const data = this.props || [];
  // }

 render(){
   const numbers = [1, 2, 3, 4, 5];
   const listItems = numbers.map((number) =>
       <li>{number*7}</li>
     );

     const a = this.props.now
     const b = a.map((cc) => <h4> {cc} </h4>);
   return (

     <div className="Hello">
        <h2> {listItems} </h2>
        <h3> {b} </h3>

    </div>
   );
 }

}

export default Hello;
