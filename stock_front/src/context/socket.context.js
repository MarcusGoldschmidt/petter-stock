import React, { useState } from "react"
import { Socket } from "phoenix"
import env from "../utils/environment";


export const SocketContext = React.createContext({
    socket: {}
});

const connectSocket = (token) => {
    if (!token) {
        return null;
    }
    const socket = new Socket(env.SOCKET_URL + "/socket", { params: { token } });
    socket.connect();

    return socket;
}


export function SocketContextWrapper({ token, children }) {

    const [socket] = useState(connectSocket(token))

    return (
        <SocketContext.Provider value={{
            socket
        }}>
            {children}
        </SocketContext.Provider>
    );
}