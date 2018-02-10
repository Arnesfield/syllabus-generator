<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Curriculum extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('curriculum_model');
  }
  
  public function index() {
    $year = $this->input->post('year');
    $curriculum = $this->curriculum_model->get($year);
    $this->_json(TRUE, 'curriculum', $curriculum);
  }

  public function years() {
    $limit = NULL;
    if ($this->uri->segment(3) === 'suggest') {
      $limit = 1;
    }
    $search = strtolower($this->_filter($this->input->post('search')));
    $years = $this->curriculum_model->getYearsByQuery($search, $limit);
    $this->_json(TRUE, 'years', $years);
  }
}

?>
