import {
  BrowserRouter as Router,
  Switch,
  Route,
  Redirect
} from "react-router-dom";
import MenuWrapper from "./components/MenuWrapper";

import { UserContext } from "./context/user.context";
import Login from "./pages/auth/Login";
import Home from "./pages/Home";

function PrivateRoute({ children, ...rest }) {
  return (

    <UserContext.Consumer>
      {({ isAuthenticated, handleLogout }) =>
        <MenuWrapper handleLogout={handleLogout}>
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
          />
        </MenuWrapper>
      }
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
            <UserContext.Consumer>
              {value => value.isAuthenticated ? <Redirect
                to={{
                  pathname: "/",
                }}
              /> : <Login handleLogin={value.handleLogin} />}
            </UserContext.Consumer>
          </Route>
          <PrivateRoute path="/about">
            <h1>About</h1>
          </PrivateRoute>
          <PrivateRoute path="/users">
            <h1>Users</h1>
          </PrivateRoute>
          <PrivateRoute path="/">
            <Home></Home>
          </PrivateRoute>
        </Switch>
      </Router>
    </>
  );
}

export default App;
