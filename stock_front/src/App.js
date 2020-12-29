import {
  BrowserRouter as Router,
  Switch,
  Route,
  Redirect
} from "react-router-dom";
import MenuWrapper from "./components/MenuWrapper";
import { SocketContext } from "./context/socket.context";

import { UserContext } from "./context/user.context";
import Login from "./pages/auth/Login";
import Home from "./pages/Home";
import ProductSession from "./pages/product/ProductSession";

function PrivateRoute({ children, ...rest }) {
  return (

    <UserContext.Consumer>
      {(context) => {
        return (
          <MenuWrapper handleLogout={context.handleLogout}>
            <Route
              {...rest}
              render={({ location }) =>
                context.isAuthenticated ? (
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
        )
      }}
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
          <PrivateRoute exact path="/produtos/adicionar">
            <UserContext.Consumer>
              {({ user }) =>
                <SocketContext.Consumer>
                  {({ socket }) => <ProductSession
                    socket={socket}
                    token={user.tokens.token}
                  ></ProductSession>}
                </SocketContext.Consumer>
              }
            </UserContext.Consumer>
          </PrivateRoute>
          <PrivateRoute path="/users">
            <h1>Users</h1>
          </PrivateRoute>
          <PrivateRoute exact path="/">
            <Home></Home>
          </PrivateRoute>
        </Switch>
      </Router>
    </>
  );
}

export default App;
