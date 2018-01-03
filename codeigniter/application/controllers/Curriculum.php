<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('curriculum_model');
    $this->load->library('session');
  }
  
  public function index() {
    $year = $this->input->post('year');
    $curriculum = $this->curriculum_model->get($year);
    echo json_encode(array('curriculum' => $curriculum));
  }

  public function years() {
    $search = strtolower(strip_tags(trim(addslashes($this->input->post('search')))));
    $years = $this->curriculum_model->getYearsByQuery($search);
    echo json_encode(array('years' => $years));
  }
}

?>
