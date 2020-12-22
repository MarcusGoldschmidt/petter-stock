import { useEffect, useState } from "react";

const useSession = (defaultValue, keyStore) => {
    const [value, setValue] = useState(JSON.parse(sessionStorage.getItem(keyStore)) || defaultValue);

    useEffect(() => {
        sessionStorage.setItem(keyStore, JSON.stringify(value));
    }, [value, keyStore]);

    return [value, setValue]
};

export default useSession;