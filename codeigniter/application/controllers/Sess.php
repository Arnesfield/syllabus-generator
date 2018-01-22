<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sess extends MY_Custom_Controller {
  public function index() {
    $isset = ($user = $this->session->userdata('user')) && TRUE;
    $this->_json(array(
      'user' => $user,
      'isset' => $isset
    ));
  }
}

?>