import environment from "./environment";
import { UserContext } from "../context/user.context"

const axios = require('axios').default;
const axiosAuth = require('axios').default;

axiosAuth.defaults.baseURL = environment.API_URL;

axios.defaults.baseURL = environment.API_URL;
axios.defaults.headers.post['Content-Type'] = 'application/json';
axios.defaults.headers.put['Content-Type'] = 'application/json';
axios.defaults.headers.delete['Content-Type'] = 'application/json';

const { token, logout } = UserContext._currentValue;

axios.interceptors.request.use(async (config) => {
    if (
        !config.url.endsWith('login') ||
        !config.url.endsWith('refresh') ||
        !config.url.endsWith('signup')
    ) {
        const userTokenExpiration = new Date(token.expiration);
        const today = new Date();
        if (today > userTokenExpiration) {
            // TODO: criar refresh token
            // eslint-disable-next-line no-unused-vars
            const userRefreshToken = token.userRefreshToken;
        } else {
            const userToken = token.token;
            config.headers.Authorization = `Bearer ${userToken}`;
        }
    }

    return config;
}, (error) => {
    // I cand handle a request with errors here
    return Promise.reject(error);
});

const handlerError = (response) => {
    if (response.status === 401) {
        logout()
    }
};

const http = {
    async get(url, data = {}) {
        try {
            const response = await axios.get(url, { params: { ...data } });
            return response.data
        } catch (e) {
            handlerError(e.response);
            return null;
        }
    },
    async delete(url, id, showNotification = true) {
        try {
            const response = await axios.delete(url, { data: { id } });

            return response.data
        } catch (e) {
            handlerError(e.response);
            return null;
        }

    },
    async put(url, data = {}, showNotification = true) {
        try {
            const response = await axios.put(url, data);

            return response.data
        } catch (e) {
            handlerError(e.response);
            return null;
        }
    },
    async post(url, data = {}, showNotification = true) {
        try {
            const response = await axios.post(url, data);

            return response.data
        } catch (e) {
            handlerError(e.response);
            return null;
        }
    },
};

export default http;