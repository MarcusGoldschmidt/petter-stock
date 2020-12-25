import { useEffect, useState } from "react";

const useLocalStorage = (defaultValue, keyStore) => {
    const [value, setValue] = useState(JSON.parse(window.localStorage.getItem(keyStore)) || defaultValue);

    useEffect(() => {
        window.localStorage.setItem(keyStore, JSON.stringify(value));
    }, [value, keyStore]);

    return [value, setValue]
};

export default useLocalStorage;