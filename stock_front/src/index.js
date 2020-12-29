import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import reportWebVitals from './reportWebVitals';

// Context
import { UserContext, UserContextWrapper } from "./context/user.context";

// Style
import 'antd/dist/antd.css';
import './assets/sass/app.scss';
import { SocketContextWrapper } from './context/socket.context';

// eslint-disable-next-line no-extend-native
Date.prototype.addDays = function (days) {
  var date = new Date(this.valueOf());
  date.setDate(date.getDate() + days);
  return date;
}

ReactDOM.render(
  <React.StrictMode>
    <UserContextWrapper>
      <UserContext.Consumer>
        {({ user }) => (<>
          <SocketContextWrapper
            token={user.tokens.token}
          >
            <App />
          </SocketContextWrapper>
        </>)}
      </UserContext.Consumer>
    </UserContextWrapper>
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
