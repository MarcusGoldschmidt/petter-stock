import Quagga from 'quagga';
import { nanoid } from 'nanoid'
import { useEffect, useState } from 'react';
import { Button } from 'antd';
import { openNotificationWithIcon } from '../utils/notification';

export default function BarcodeScanner({ onRead = () => { } }) {

    const [scannerId] = useState(nanoid(10));

    useEffect(() => {
        Quagga.init({
            inputStream: {
                type: "LiveStream",
                target: document.querySelector(`#${scannerId.toString()}`)
            },
            locator: {
                patchSize: "medium",
                halfSample: true
            },
            numOfWorkers: 2,
            decoder: {
                readers: ["code_128_reader"]
            }
        }, function (err) {
            if (err) {
                return console.log(err);
            }
            Quagga.start();
        });
        Quagga.onDetected(onRead);

        return () => {
            Quagga.offDetected(onRead);
            Quagga.stop()
        }
    }, [onRead, scannerId]);


    return (
        <>
            <Button onClick={() => openNotificationWithIcon('success')}>Success</Button>
            <Button onClick={() => openNotificationWithIcon('info')}>Info</Button>
            <Button onClick={() => openNotificationWithIcon('warning')}>Warning</Button>
            <Button onClick={() => openNotificationWithIcon('error')}>Error</Button>
            <div id={scannerId.toString()} className="viewport" />
        </>
    )
}