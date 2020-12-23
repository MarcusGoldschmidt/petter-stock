import { Row, Col, Divider, Form, Button, Input, Typography } from 'antd'
import LoginImage from "../../assets/svg/undrawPreparetion.svg"
import "./login.scss"

const { Title } = Typography;


export default function Login({handleLogin}) {

    const onFinish = async values => {

        await handleLogin(values.email, values.senha)
    };

    const onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    }

    return (
        <>
            <Row style={{
                paddingRight: `2%`,
                paddingLeft: `2%`
            }}>
                <Col
                    className="col_image"
                    xs={24} sm={24} md={16} lg={16} xl={16}>
                    <img className="img-responsive" src={LoginImage} alt="stock"></img>
                </Col>
                <Col
                    className="col_login-form"
                    xs={24} sm={24} md={8} lg={8} xl={8}
                >
                    <Divider orientation="left"><Title level={3}>Login</Title></Divider>
                    <Form
                        name="basic"
                        onFinish={onFinish}
                        onFinishFailed={onFinishFailed}
                    >
                        <Form.Item
                            label="Email"
                            name="email"
                            rules={[{ required: true, message: 'Informe seu email!' }]}
                        >
                            <Input />
                        </Form.Item>

                        <Form.Item
                            label="Senha"
                            name="senha"
                            rules={[{ required: true, message: 'Informe a senha!' }]}
                        >
                            <Input.Password />
                        </Form.Item>

                        <Form.Item style={{ textAlign: `right` }}>
                            <Button type="primary" htmlType="submit">
                                Entrar
                            </Button>
                        </Form.Item>
                    </Form>
                </Col>
            </Row>
        </>
    );
}