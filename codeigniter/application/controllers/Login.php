<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('login_model');
    $this->load->library('session');
  }

  private $max_age = 2*3600*1000;
  
  public function index() {
    $username = $this->input->post('username');
    $password = $this->input->post('password');

    // find user in database with username (id)
    $users = $this->login_model->get(array(
      'username' => $username
    ));

    $invalid = function($msg) {
      echo json_encode(array('success' => FALSE, 'msg' => $msg));
    };

    if (!$users) {
      // user does not exist
      $invalid('Invalid username or password.');
      return;
    }

    $user = $users[0];

    // check status
    if ($user['status'] != 1) {
      $invalid('This account has been suspended.');
      return;
    }

    // check and match password
    // invalid!
    if (!password_verify($password, $user['password'])) {
      // invalid password
      $invalid('Invalid username or password.');
      return;
    }

    // set session
    $this->session->set_userdata(array(
      'user' => $user,
      'setAt' => time() * 1000,
      'endAt' => time() * 1000 + $this->max_age + 10000
    ));
    echo json_encode(array('success' => TRUE));
  }

}

?>