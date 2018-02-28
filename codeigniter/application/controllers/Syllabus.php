<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabus extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('syllabi_model');
    $this->load->model('assigns_model');
  }
  
  public function index() {
    $assignId = $this->input->post('assignId');


    // check status of assign
    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      $this->_json(FALSE);
    }

    $assign = $assigns[0];
    if ($assign['status'] == 3) {
      $this->_json(FALSE);
    }

    $syllabi = $this->syllabi_model->getByAssignId($assignId);

    if (!$syllabi) {
      $this->_json(FALSE);
    }

    $syllabus = $syllabi[0];
    // parse json content
    $syllabus['content'] = json_decode($syllabus['content'], TRUE);
    $this->_json(TRUE, 'syllabus', $syllabus);
  }
}

?>
