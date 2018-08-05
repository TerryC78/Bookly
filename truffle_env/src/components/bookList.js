import React, {Component} from 'react'
import {Table, Button, Modal, Form, InputNumber, Input, Popconfirm} from 'antd';

class BookList extends Component {
    constructor(props) {
        super(props);
    }

	renderModal() {
        return (
            <Modal
                title="增加员工"
                visible={this.state.showModal}
                onOk={this.addEmployee}
                onCancel={() => this.setState({showModal: false})}
            >
            </Modal>
        );
    }

    render() {
        const {bookTitles} = this.state;
        return (
            <div>
                <p>bookTitles[0]</p>
            </div>
        );
    }
}

export default BookList