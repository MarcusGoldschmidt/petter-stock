import { Layout, Menu } from 'antd';
import {
    InteractionOutlined,
    LogoutOutlined,
    InboxOutlined,
    HomeOutlined,
    BarcodeOutlined
} from '@ant-design/icons';

const { SubMenu } = Menu;
const { Content, Sider } = Layout;

export default function MenuWrapper({ children, handleLogout = () => { } }) {
    return (
        <Layout style={{ height: `100%` }}>
            <Content>
                <Layout className="site-layout-background" style={{ height: "100%" }}>
                    <Sider className="site-layout-background">
                        <Menu
                            mode="inline"
                            defaultSelectedKeys={['1']}
                            defaultOpenKeys={['1']}
                            style={{ height: '100%' }}
                        >
                            <Menu.Item key="m1" icon={<HomeOutlined />}>
                                Home
                            </Menu.Item>
                            <Menu.Item key="m2" icon={<InboxOutlined />}>
                                Estoque
                            </Menu.Item>
                            <SubMenu key="m3" icon={<InteractionOutlined />} title="Entrada e saída">
                                <Menu.Item key="m3s1">Entrada</Menu.Item>
                                <Menu.Item key="m3s2">Saida</Menu.Item>
                                <Menu.Item key="m3s3">Balanço</Menu.Item>
                            </SubMenu>
                            <Menu.Item key="m4" icon={<BarcodeOutlined />}>
                                Produtos
                            </Menu.Item>
                            <Menu.Item key="m5" icon={<LogoutOutlined />} onClick={handleLogout}>
                                Sair
                            </Menu.Item>
                        </Menu>
                    </Sider>
                    <Content style={{ padding: '0 24px', minHeight: 280 }}>
                        {children}
                    </Content>
                </Layout>
            </Content>
        </Layout>
    );
}