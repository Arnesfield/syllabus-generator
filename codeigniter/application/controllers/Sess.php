<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sess extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->library('session');
  }

  public function index() {
    echo json_encode($this->session->userdata());
  }
}

?>