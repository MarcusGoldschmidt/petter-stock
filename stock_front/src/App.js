import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  Redirect
} from "react-router-dom";

import { UserContext } from "./context/user.context";
import Login from "./pages/auth/Login";

function PrivateRoute({ children, ...rest }) {
  return (
    <UserContext.Consumer>
      {({ isAuthenticated }) =>
        <Route
          {...rest}
          render={({ location }) =>
            isAuthenticated ? (
              children
            ) : (
                <Redirect
                  to={{
                    pathname: "/login",
                    state: { from: location }
                  }}
                />
              )
          }
        />}

    </UserContext.Consumer>
  );
}

function App() {

  return (
    <>
      <Router>
        <UserContext.Consumer>
          {value => value.name}
        </UserContext.Consumer>
        <Switch>
          <Route path="/login">
            <Login />
          </Route>
          <PrivateRoute path="/about">
            <h1>About</h1>
          </PrivateRoute>
          <PrivateRoute path="/users">
            <h1>Users</h1>
          </PrivateRoute>
          <PrivateRoute path="/">
            <h1>Home</h1>
          </PrivateRoute>
        </Switch>
      </Router>
    </>
  );
}

export default App;
