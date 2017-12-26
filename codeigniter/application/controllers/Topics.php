<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Topics extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('topics_model');
    $this->load->library('session');
  }
  
  public function index() {
    $search = strip_tags(trim($this->input->post('search')));
    $topics = $this->topics_model->getByQuery($search);
    echo json_encode(array('topics' => $topics));
  }
}

?>
