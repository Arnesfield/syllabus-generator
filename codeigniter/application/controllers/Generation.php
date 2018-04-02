<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Generation extends MY_Custom_Controller {
  public function __construct() {
    parent::__construct();
    $this->load->model('courses_model');
    $this->load->model('assigns_model');
    $this->load->model('syllabi_model');
  }

  public function index() {
    $assignId = $this->input->post('assignId') ? $this->input->post('assignId') : FALSE;

    if (!$assignId) {
      $this->_json(FALSE);
    }
    
    // get assign
    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      $this->_json(FALSE);
    }

    $assign = $assigns[0];
    $content = json_decode($assign['content'], TRUE);

    $uid = $this->session->userdata('user')['id'];

    // if uid is not the same as assigned, do not proceed
    if ($uid != $content['assigned']['id']) {
      $this->_json(FALSE);
    }

    // also format assign and course
    $assign = $this->_createAssigns(array($assign))[0];
    $course = $this->_formatCourses(array($assign['content']['course']), TRUE)[0];

    $data = array(
      'course' => $course,
      'assign' => $assign
    );
    
    // also send the syllabi if it exists
    $syllabi = $this->syllabi_model->getByAssignId($assignId);

    if ($syllabi) {
      // if syllabus exists
      $syllabus = $this->_formatSyllabi($syllabi)[0];
      $data['syllabus'] = $syllabus;
    }

    // get default content here alsooo
    $syllabusContent = $this->_getSyllabusContent();
    $data['syllabusContent'] = $syllabusContent;
    
    $this->_json(TRUE, $data);
  }
}

?>
