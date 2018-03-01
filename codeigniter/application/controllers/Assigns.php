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
    $assigns = $this->assigns_model->getAssigned($id);
    $assigns = $this->_createAssigns($assigns);
    $this->_json(TRUE, 'assigns', $assigns);
  }

  public function approval_action() {
    $uid = $this->session->userdata('user')['id'];
    $assignId = $this->input->post('assignId');
    $value = $this->input->post('value');

    $assigns = $this->assigns_model->get($assignId);

    if (!$assigns) {
      $this->_json(FALSE);
    }

    // get assign
    // check if uid exists in assign inst

    $assign = $assigns[0];
    $content = json_decode($assign['content'], TRUE);
    $assigned = $content['assigned'];
    $subs = $content['sub'];
    $subs_ids = array();
    if ($subs) {
      $subs_ids = $this->assigns_model->_to_col($subs, 'id');
    }
    // push assigned to subs
    $listOfValidIDs = $subs_ids;
    array_push($listOfValidIDs, $assigned);
    $allowAccess = in_array($uid, $listOfValidIDs);

    if (!$allowAccess) {
      $this->_json(FALSE);
    }

    // get assign
    // update user status
    // update assigns model if all users approve
    // deny if at least one denies

    $indexOfUid = array_search($uid, $subs_ids);
    if ($indexOfUid === FALSE) {
      $this->_json(FALSE);
    }

    $content['sub'][$indexOfUid]['status'] = $value;

    // get status of all subs
    $allSubStatus = $this->assigns_model->_to_col($content['sub'], 'status');
    $rejectSyllabus = array_search(0, $allSubStatus) !== FALSE;
    $acceptSyllabus = array_search(2, $allSubStatus) === FALSE;
    
    $status = 2;
    if ($rejectSyllabus) {
      $status = 0;
    } else if ($acceptSyllabus) {
      $status = 1;
    }

    $content = json_encode($content);

    $data = array(
      'content' => $content,
      'updated_at' => time(),
      'status' => $status
    );
    $where = array('id' => $assignId);
    $res = $this->assigns_model->update($data, $where);
    $this->_json($res, 'content', json_decode($content, TRUE));
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
