import { notification } from 'antd';

export const notification_types = {
    SUCCESS: "success",
    INFO: "info",
    WARNING: "warning",
    ERROR: "error"
};

export const openNotificationWithIcon = (type, menssage = "Sucumba Chico") => {
    notification[type]({
        description: menssage 
    });
};