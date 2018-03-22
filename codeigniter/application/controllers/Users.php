<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('users_model');
  }
  
  public function index() {
    $users = $this->users_model->get();
    $this->_json(TRUE, array(
      'users' => $users,
      'currId' => $this->session->userdata('user')['id']
    ));
  }

  public function search() {
    $search = $this->_filter($this->input->post('search'));
    $users = $this->users_model->getByQuery($search);
    $this->_json(TRUE, 'users', $users);
  }

  // admin
  public function add() {
    $post_values = array('fname', 'mname', 'lname', 'username', 'password', 'img_src', 'type', 'status');
    foreach ($post_values as $value) {
      $initial = $this->_filter($this->input->post($value));
      $user[$value] = $value == 'password' ? password_hash($initial, PASSWORD_BCRYPT) : $initial;
    }
    $user['auth'] = json_encode(array($user['type']));
    $time = time();
    $user['created_at'] = $time;
    $user['updated_at'] = $time;
    $res = $this->users_model->insert($user);
    $this->_json($res);
  }

  public function addCsv() {
    $users = $this->input->post('users');
    // foreach user, add auth
    foreach ($users as $key => $user) {
      $users[$key]['auth'] = json_encode(array($user['type']));
      $time = time();
      if (!isset($user['created_at'])) {
        $users[$key]['created_at'] = $time;
      }
      if (!isset($user['updated_at'])) {
        $users[$key]['updated_at'] = $time;
      }
    }
    $res = $this->users_model->insertMultiple($users);
    $this->_json($res);
  }

  public function delete() {
    $id = $this->input->post('id');
    $data = array(
      'status' => -1,
      'updated_at' => time()
    );
    $where = array('id' => $id);
    $res = $this->users_model->update($data, $where);
    $this->_json($res);
  }
}

?>
