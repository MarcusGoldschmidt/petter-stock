import { notification } from 'antd';

export const notification_types = {
    SUCCESS: "success",
    INFO: "info",
    WARNING: "warning",
    ERROR: "error"
};

export const openNotificationWithIcon = (type, menssage) => {
    notification[type]({
        description: menssage
    });
};