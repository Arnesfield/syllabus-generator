<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabi extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('syllabi_model');
  }
  
  public function cid() {
    $course_id = $this->input->post('courseId');
    $syllabi = $this->syllabi_model->getByCourseId($course_id);
    $this->_json(TRUE, 'syllabi', $syllabi);
  }
}

?>
