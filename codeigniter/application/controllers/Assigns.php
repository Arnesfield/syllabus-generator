<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Assigns extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('assigns_model');
  }
  
  public function index() {
    $assigns = $this->assigns_model->get();
    $assigns = $this->_createAssigns($assigns);
    $this->_json(TRUE, 'assigns', $assigns);
  }
  
  public function my() {
    $id = $this->session->userdata('user')['id'];
    $assigns = $this->assigns_model->getRelated($id);
    $assigns = $this->_createAssigns($assigns);
    $this->_json(TRUE, 'assigns', $assigns);
  }

  public function approval_action() {
    $uid = $this->session->userdata('user')['id'];
    $assignId = $this->input->post('assignId');
    $value = $this->input->post('value');
    $plevel = $this->input->post('level');

    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      $this->_json(FALSE);
    }

    // get assign
    // check if uid exists in assign inst

    $assign = $assigns[0];
    $content = json_decode($assign['content'], TRUE);
    $assigned_id = $content['assigned']['id'];

    // loop through levels
    // if that was you, edit your status
    // then update your data

    $did_update = FALSE;
    foreach ($content['levels'][$plevel] as $key => $user) {
      if ($uid == $user['id']) {
        $content['levels'][$plevel][$key]['status'] = $value;
        $did_update = TRUE;
        break;
      }
    }

    if (!$did_update) {
      $this->_json(FALSE);
    }

    // get status of all levels combined
    $all_status = array();
    foreach ($content['levels'] as $key => $level) {
      foreach ($level as $lvl_key => $user) {
        array_push($all_status, $user['status']);
      }
    }
    $all_status = array_unique($all_status);

    $reject = array_search(0, $all_status) !== FALSE;
    $accept = array_search(2, $all_status) === FALSE;

    $status = 2;
    if ($reject) { $status = 0; }
    else if ($accept) { $status = 1; }

    $content = json_encode($content);

    $data = array(
      'content' => $content,
      'updated_at' => time(),
      'status' => $status
    );
    $where = array('id' => $assignId);
    $res = $this->assigns_model->update($data, $where);

    if (!$res) {
      $this->_json(FALSE);
    }
    
    $plevel += 1;
    $text = "<strong>level $plevel</strong> &mdash; ";
    
    $data = array(
      'assign_id' => $assignId,
      'content' => $text . ($value == 1 ? 'approved this syllabus.' : 'disapproved this syllabus.'),
      'type' => 'approval'
    );
    
    $res = $this->_insertWorkflowLog($data);
    $this->_json($res);
  }

  public function add() {
    $uid = $this->session->userdata('user')['id'];
    $content = $this->input->post('content');
    
    $data = array(
      'content' => $content,
      'created_by' => $uid,
      'created_at' => time(),
      'updated_at' => time(),
      'status' => 3
    );

    $res = $this->assigns_model->insert($data);
    $this->_json($res);
  }
}

?>
