import { Button, Card, Col, Divider, Row } from "antd";
import Title from "antd/lib/typography/Title";
import HeatMapChart from "../components/charts/HeatMapChart";
import useWindowDimensions from "../hooks/useWindowDimensions";
import {
    BarcodeOutlined,
    InboxOutlined,
    AlertOutlined,
    PlusCircleOutlined
} from '@ant-design/icons';
import { useState } from "react";
import { generateData } from "../utils/randomData";
import { useHistory } from "react-router-dom";

const iconSize = {
    fontSize: "2rem"
}

const generateProductsExpiration = () => {
    const result = {}

    const today = new Date()

    for (let i = 0; i < 600; i++) {
        const value = generateData(-100, 5);
        result[today.addDays(i).valueOf().toString().substr(0, 10)] = value > 0 ? value : 0;
    }

    return result;
}


export default function Home() {

    const {
        width
    } = useWindowDimensions()

    const [productsExpiration] = useState(generateProductsExpiration());
    const history = useHistory()

    return (<>
        <Divider orientation="left"><Title level={2}>Home</Title></Divider>
        <Button
            type="primary"
            icon={<PlusCircleOutlined />}
            size="large"
            onClick={() => history.push("/produtos/adicionar")}
        >
            Adicionar Items
        </Button>
        <br></br>
        <Row
            style={{
                marginTop: "1rem"
            }}
            gutter={[16, 16]}
        >
            <Col
                xs={24} sm={12} md={12} lg={8} xl={8}>
                <Card >
                    <Card.Meta
                        title="Produtos cadastrados"
                        avatar={<BarcodeOutlined style={iconSize} />}
                    ></Card.Meta>
                    <br />
                    <Title level={3} style={{
                        textAlign: "center"
                    }}>
                        54
                    </Title>
                </Card>
            </Col>
            <Col
                xs={24} sm={12} md={12} lg={8} xl={8}>
                <Card >
                    <Card.Meta
                        title="Quantidade de produtos"
                        avatar={<InboxOutlined style={iconSize} />}
                    ></Card.Meta>
                    <br />
                    <Title level={3} style={{
                        textAlign: "center"
                    }}>
                        123
                    </Title>
                </Card>
            </Col>
            <Col
                xs={24} sm={12} md={12} lg={8} xl={8}>
                <Card >
                    <Card.Meta
                        title="Alguma métrica"
                        avatar={<AlertOutlined style={iconSize} />}
                    ></Card.Meta>
                    <br />
                    <Title level={3} style={{
                        textAlign: "center"
                    }}>
                        10
                    </Title>
                </Card>
            </Col>

        </Row>
        <br />
        <Row>
            <Col
                xs={24} sm={24} md={24} lg={24} xl={24}>
                <Card title="Produtos a vencer">
                    <HeatMapChart
                        data={productsExpiration}
                        end={new Date().addDays((width - 150) * 0.4)}
                    ></HeatMapChart>
                </Card>
            </Col>
        </Row>
    </>)
}