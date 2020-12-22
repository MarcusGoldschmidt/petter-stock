import React, { useState } from 'react';
import useSession from '../hooks/useSession';
import environment from "../utils/environment";
const axiosAuth = require('axios').default;

axiosAuth.defaults.baseURL = environment.API_URL;

export const initialValueUser = {
    name: "Marcus Goldschmidt Oliveira",
    email: "",
    token: {
        value: "",
        refreshToken: "",
        expiration: null,
    }
};

export const UserContext = React.createContext(initialValueUser);

export function UserContextWrapper(props) {

    const [user, setUser] = useSession(initialValueUser, "applicationUser");
    const [isAuthenticated, setIsAuthenticated] = useState(false);
    const [isFetching, setIsFetching] = useState(false);

    const login = async (email, password) => {
        try {
            const response = await axiosAuth.post("login", {
                email,
                password
            });

            return response.data.data
        } catch (e) {
            return null;
        }
    }

    const handleLogin = async (email, password) => {
        setIsFetching(true);
        const response = await login(email, password);
        setIsFetching(false);

        if (!response) {
            return
        }

        setUser(response);
        setIsAuthenticated(true);
    };

    const handleLogout = () => {
        setIsAuthenticated(false);
        setUser(initialValueUser);
    };

    return (
        <UserContext.Provider value={{
            user: user,
            handleLogin,
            isAuthenticated,
            isFetching,
            handleLogout
        }}>
            {props.children}
        </UserContext.Provider>
    );
}