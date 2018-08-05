import React, { Component } from 'react'
import PubFree from '../build/contracts/PubFree.json'
import getWeb3 from './utils/getWeb3'

import { Layout, Menu, Spin, Alert } from 'antd';

import BookList from './components/bookList';
import Employee from './components/Employee';

import 'antd/dist/antd.css';
import './App.css';

const { Header, Content, Footer } = Layout;

class App extends Component {
    constructor(props) {
        super(props)

        this.state = {
            storageValue: 0,
            web3: null,
            mode: 'aswlBooks',
        }
    }

    componentWillMount() {
        // Get network provider and web3 instance.
        // See utils/getWeb3 for more info.

        getWeb3
            .then(results => {
                this.setState({
                    web3: results.web3
                })

                // Instantiate contract once web3 provided.
                this.instantiateContract()
            })
            .catch(() => {
                console.log('Error finding web3.')
            })
    }

    instantiateContract() {
        /*
         * SMART CONTRACT EXAMPLE
         *
         * Normally these functions would be called in the context of a
         * state management library, but for convenience I've placed them here.
         */

        const contract = require('truffle-contract')
        const Platform = contract(PubFree)
        Platform.setProvider(this.state.web3.currentProvider)
        Platform.listBook().call().then((error, titles) => {
            this.setState({
                bookTitles: titles
            });
        })

        // Get accounts.
        this.state.web3.eth.getAccounts((error, accounts) => {
            this.setState({
                account: accounts[0],
            });
            Platform.deployed().then((instance) => {
                // for debug
                window.payroll = instance
                this.setState({
                    payroll: instance
                });
            })
        })
    }

    onSelectTab = ({key}) => {
        this.setState({
            mode: key
        });
    }

    renderContent = () => {
        const { account, payroll, bookTitles, web3, mode } = this.state;

        switch(mode) {
            case 'allBooks':
                return <BookList account={account} bookList={bookTitles} web3={web3} />
            default:
                return <Alert message="请选一个模式" type="info" showIcon />
        }
    }

    render() {
        return (
            <Layout>
                <Header className="header">
                    <div className="logo">PubFree</div>
                    <Menu
                        theme="dark"
                        mode="horizontal"
                        defaultSelectedKeys={['allBooks']}
                        style={{ lineHeight: '64px' }}
                        onSelect={this.onSelectTab}
                    >
                        <Menu.Item key="allBooks">All Books</Menu.Item>
                        <Menu.Item key="myProfile">My Profile</Menu.Item>
                    </Menu>
                </Header>
                <Content style={{ padding: '0 50px' }}>
                    <Layout style={{ padding: '24px 0', background: '#fff', minHeight: '600px' }}>
                        {this.renderContent()}
                    </Layout>
                </Content>
                <Footer style={{ textAlign: 'center' }}>
                    PubFree ©2018
                </Footer>
            </Layout>
        );
    }
}

export default App