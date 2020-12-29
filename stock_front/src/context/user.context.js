import React, { useEffect, useState } from 'react';
import useLocalStorage from '../hooks/useLocalStorage';
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
    handleLogout: () => { },
    handleRefreshToken: () => { }
});

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

const refreshToken = async (refreshToken) => {
    try {
        const response = await axiosAuth.post("/auth/refresh-token", {
            refreshToken
        });

        return response.data
    } catch (e) {
        return null;
    }
}

export function UserContextWrapper(props) {

    const [user, setUser] = useLocalStorage(initialValueUser, "applicationUser");
    const [isAuthenticated, setIsAuthenticated] = useState(!!user.email);
    const [isFetching, setIsFetching] = useState(false);

    const handleRefreshToken = async () => {
        const userResponse = await refreshToken(user.tokens.refreshToken);

        if (!userResponse) {
            setIsAuthenticated(false);
            return;
        }

        setUser(userResponse);
        return userResponse;
    }

    useEffect(() => {
        axiosAuth
            .post("/auth/check-user", {}, {
                headers: {
                    Authorization: `Bearer ${user.tokens.token}`
                }
            })
            .then(() => setIsAuthenticated(true))
            .catch(async () => {
                await handleRefreshToken()
            });
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

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
            handleLogout,
            handleRefreshToken
        }}>
            {props.children}
        </UserContext.Provider>
    );
}