import Quagga from 'quagga';
import { nanoid } from 'nanoid'
import { useEffect, useState } from 'react';

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
            <div id={scannerId.toString()} className="viewport" />
        </>
    )
}