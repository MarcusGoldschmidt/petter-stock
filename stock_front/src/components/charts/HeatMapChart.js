import { useRef } from "react";
import ReactFrappeChart from "react-frappe-charts";

export default function HeatMapChart({ start, end, data }) {

    const chartRef = useRef();

    return (<>
        <ReactFrappeChart
            style={{
                maxWidth: "100%"
            }}
            ref={chartRef}
            type="heatmap"
            discreteDomains={1}
            data={{
                labels: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab", "Dom"],
                dataPoints: data,
                start: start || new Date(),
                end: end || new Date().addDays(365)
            }}
            colors={['#ebedf0', '#c0ddf9', '#73b3f3', '#3886e1', '#17459e']}
        ></ReactFrappeChart>
    </>);
}