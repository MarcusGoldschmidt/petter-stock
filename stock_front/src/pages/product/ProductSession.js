import { useEffect, useRef, useState } from "react"
import { Presence } from "phoenix"
import CollapsePanel from "antd/lib/collapse/CollapsePanel"
import { Collapse } from "antd"
import UAParser from "ua-parser-js";

const GetDeviceIcon = ({ userAgent }) => {

    const ua = UAParser(userAgent);

    return (
        <>
            <p>A</p>
        </>
    )
}

const joinChannel = (socket, token, handleOk = (_) => { }, handleError = (_) => { }) => {

    const channel = socket.channel("session:room", {
        token,
        userAgent: navigator.userAgent
    })

    channel.join()
        .receive("ok", handleOk)
        .receive("error", handleError)
        .receive("timeout", handleError)

    return channel;
}

export default function ProductSession({ socket, token }) {

    const socketToken = useRef({ socket, token })
    const channelRef = useRef(null);
    const presenceRef = useRef(null)

    const [onlineUsers, setOnlineUsers] = useState([]);

    useEffect(() => {

        const { socket, token } = socketToken.current;

        channelRef.current = joinChannel(socket, token);

        presenceRef.current = new Presence(channelRef.current);

        const channel = channelRef.current;
        const presence = presenceRef.current;

        presence.onSync(() => {

            setOnlineUsers(presence.list().map(({ metas }) => {
                const user = {
                    ...metas[0]
                };

                return {
                    user,
                    metas: metas
                }
            }));
        });

        return () => {
            channel.leave()
        }
    }, [])

    return (<>
        <h1>Olá</h1>
        <Collapse defaultActiveKey={[0]} ghost>
            {onlineUsers.map(({ user, metas }, i) =>
                <CollapsePanel header={user.full_name} key={i}>
                    {metas.map((value, j) =>
                        <div key={j}>
                            <p>{value.user_agent}</p>
                            <GetDeviceIcon userAgent={value.user_agent}></GetDeviceIcon>
                            <br></br>
                        </div>
                    )}
                </CollapsePanel>
            )}

        </Collapse>
    </>)
}