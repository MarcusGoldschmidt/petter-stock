import React, { useEffect, useState } from 'react';
import useSession from '../hooks/useSession';
import environment from "../utils/environment";
import { openNotificationWithIcon } from "../utils/notification";

const axiosAuth = require('axios').default;

axiosAuth.defaults.baseURL = environment.API_URL;

export const initialValueUser = {
    name: "",
    email: "",
    tokens: {
        token: "",
        refreshToken: "",
    }
};

export const UserContext = React.createContext({
    user: initialValueUser,
    handleLogin: () => { },
    isAuthenticated: false,
    isFetching: false,
    handleLogout: () => { }
});

export function UserContextWrapper(props) {

    const [user, setUser] = useSession(initialValueUser, "applicationUser");
    const [isAuthenticated, setIsAuthenticated] = useState(false);
    const [isFetching, setIsFetching] = useState(false);

    useEffect(() => {
        setIsAuthenticated(user.email !== "");
    }, [user]);

    const login = async (email, password) => {
        try {
            const response = await axiosAuth.post("/auth/login", {
                email,
                password
            });

            return response.data
        } catch (e) {
            return null;
        }
    }

    const handleLogin = async (email, password) => {
        setIsFetching(true);
        const response = await login(email, password);
        setIsFetching(false);

        if (!response) {
            openNotificationWithIcon("warning", "Sua conta ou senha está incorreta.")
            return
        }

        setUser(response);
        setIsAuthenticated(true);

        openNotificationWithIcon("success", "Login efetuado")
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