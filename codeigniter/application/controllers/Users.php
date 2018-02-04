<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('users_model');
  }
  
  public function index() {
    $users = $this->users_model->get();
    $this->_json(array(
      'users' => $users,
      'currId' => $this->session->userdata('user')['id']
    ));
  }

  // admin
  public function add() {
    $post_values = array('fname', 'mname', 'lname', 'username', 'password', 'type', 'status');
    foreach ($post_values as $value) {
      $initial = $this->_filter($this->input->post($value));
      $user[$value] = $value == 'password' ? password_hash($initial, PASSWORD_DEFAULT) : $initial;
    }
    $res = $this->users_model->insert($user);
    $this->_json('success', $res);
  }
}

?>
