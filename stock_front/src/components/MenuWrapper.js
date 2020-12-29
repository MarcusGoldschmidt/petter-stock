import { Layout, Menu } from 'antd';
import {
    InteractionOutlined,
    LogoutOutlined,
    FormOutlined,
    InboxOutlined,
    HomeOutlined,
    BarcodeOutlined
} from '@ant-design/icons';
import { useHistory } from 'react-router-dom';

const { SubMenu } = Menu;
const { Content, Sider } = Layout;

export default function MenuWrapper({ children, handleLogout = () => { } }) {
    const history = useHistory();

    return (
        <Layout style={{ height: `100%` }}>
            <Content>
                <Layout className="site-layout-background" style={{ height: "100%" }}>
                    <Sider className="site-layout-background"
                        breakpoint="lg"
                        collapsedWidth="0">
                        <Menu
                            theme="dark"
                            mode="inline"
                            defaultSelectedKeys={['m1']}
                            defaultOpenKeys={['1']}
                        >
                            <Menu.Item key="m1"
                                onClick={() => history.push("/")}
                                icon={<HomeOutlined />}>
                                Home
                            </Menu.Item>
                            <Menu.Item key="m2"
                                onClick={() => history.push("/estoque")}
                                icon={<InboxOutlined />}>
                                Estoque
                            </Menu.Item>
                            <SubMenu key="m3" icon={<InteractionOutlined />} title="Entrada e saída">
                                <Menu.Item key="m3s1">Entrada</Menu.Item>
                                <Menu.Item key="m3s2">Saida</Menu.Item>
                                <Menu.Item key="m3s3">Balanço</Menu.Item>
                            </SubMenu>
                            <Menu.Item key="m4"
                                onClick={() => history.push("/produtos")}
                                icon={<BarcodeOutlined />}>
                                Produtos
                            </Menu.Item>
                            <Menu.Item key="m5"
                                onClick={() => history.push("/pedidos")}
                                icon={<FormOutlined />}>
                                Pedidos
                            </Menu.Item>
                            <Menu.Item key="m6" icon={<LogoutOutlined />} onClick={handleLogout}>
                                Sair
                            </Menu.Item>
                        </Menu>
                    </Sider>
                    <Content style={{ padding: '0 24px' }}>
                        {children}
                    </Content>
                </Layout>
            </Content>
        </Layout>
    );
}