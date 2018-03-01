<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Comments extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('comments_model');
  }
  
  public function index() {
    $this->load->model('assigns_model');

    $uid = $this->session->userdata('user')['id'];
    $assignId = $this->input->post('assignId');

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
    $listOfValidIDs = $subs_ids;
    // push assigned to subs
    array_push($listOfValidIDs, $assigned);
    $allowAction = in_array($uid, $subs_ids);
    $allowComment = in_array($uid, $listOfValidIDs);

    // also get status of uid
    $myStatus = false;
    $indexOfUid = array_search($uid, $subs_ids);
    if ($indexOfUid !== FALSE) {
      if ($subs[$indexOfUid]['status'] == 1) {
        $myStatus = 'accept';
      } else if ($subs[$indexOfUid]['status'] == 0) {
        $myStatus = 'reject';
      }
    }

    $comments = $this->comments_model->get($assignId);
    
    // get user of comments
    $user_ids = $this->comments_model->_to_col($comments, 'user_id');
    $users = $this->comments_model->getUsersByIds($user_ids);

    // convert index => value to id => value
    $newUsers = array();
    foreach ($users as $key => $user) {
      $newUsers[$user['id']] = $user;
    }

    // per comment, assign user prop
    foreach ($comments as $key => $comment) {
      $comments[$key]['user'] = $newUsers[$comment['user_id']];
    }

    $this->_json(TRUE, array(
      'comments' => $comments,
      'allowComment' => $allowComment,
      'allowAction' => $allowAction,
      'myStatus' => $myStatus
    ));
  }
  
  public function comment() {
    $uid = $this->session->userdata('user')['id'];
    $assignId = $this->input->post('assignId');
    $comment = $this->_filter($this->input->post('comment'));
    
    $data = array(
      'user_id' => $uid,
      'assign_id' => $assignId,
      'comment' => $comment,
      'created_at' => time(),
      'status' => 1
    );
    
    $res = $this->comments_model->insert($data);
    $this->_json($res);
  }

  public function delete() {
    $uid = $this->session->userdata('user')['id'];
    $id = $this->input->post('id');

    $data = array('status' => -1);
    $where = array('id' => $id, 'user_id' => $uid);

    $res = $this->comments_model->update($data, $where);
    $this->_json($res);
  }
}

?>
