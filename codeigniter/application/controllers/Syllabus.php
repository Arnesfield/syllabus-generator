<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Syllabus extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('syllabi_model');
    $this->load->model('assigns_model');
  }
  
  public function index() {
    $uid = $this->session->userdata('user')['id'];
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

    $allow_viewing = FALSE;
    $content = json_decode($assign['content'], TRUE);
    
    // if uid not included, do not include
    if ($uid == $assign['created_by']) {
      $allow_viewing = TRUE;
    }

    $assigned_id = $content['assigned']['id'];
    if ($uid == $assigned_id) {
      $allow_viewing = TRUE;
    }

    // loop on levels
    if (!$allow_viewing) {
      foreach ($content['levels'] as $key => $level) {
        foreach ($level as $lvl_key => $user) {
          if ($uid == $user['id']) {
            $allow_viewing = TRUE;
            break;
          }
        }
      }
    }

    if (!$allow_viewing) {
      $this->_json(FALSE);
    }

    // also include the assign
    $assign = $this->_createAssigns($assigns)[0];
    $syllabus = $this->_formatSyllabi($syllabi)[0];
    $this->_json(TRUE, array(
      'syllabus' => $syllabus,
      'assign' => $assign
    ));
  }
}

?>
