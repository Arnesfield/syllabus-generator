<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Courses extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('courses_model');
    $this->load->library('session');
  }
  
  public function index() {
    $search = strip_tags(trim($this->input->post('search')));
    $courses = $this->courses_model->getByQuery($search);
    echo json_encode(array('courses' => $courses));
  }
}

?>
