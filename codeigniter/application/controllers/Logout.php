<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Logout extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->library('session');
  }

  public function index() {
    session_destroy();
    echo json_encode(array('success' => TRUE));
  }
}

?>