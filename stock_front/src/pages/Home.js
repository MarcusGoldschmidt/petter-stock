import BarcodeScanner from "../components/BarcodeScanner";

export default function Home() {
    return (<>
        <h1>Home</h1>
        <BarcodeScanner onRead={(e) => console.log(e)}></BarcodeScanner>
    </>)
}