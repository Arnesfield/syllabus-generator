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
    $newAssigns = $this->_createAssigns($assigns);

    $content = json_decode($assign['content'], TRUE);
    $assigned_id = $content['assigned']['id'];

    // change sub to levels
    $myStatus = array();
    $revealAction = array();
    $allowAction = array();
    $allowComment = array();
    
    foreach ($content['levels'] as $key => $level) {
      $myStatus[$key] = FALSE;
      $allowAction[$key] = FALSE;
      $allowComment[$key] = FALSE;

      // $level is an array of objects
      foreach ($level as $lvl_key => $user) {

        // include my status here
        if ($uid == $user['id']) {
          $status = $user['status'];
          if ($status == 1) {
            $myStatus[$key] = 'approve';
          } else if ($status == 0) {
            $myStatus[$key] = 'disapprove';
          }
          // allow action and comment here
          $allowAction[$key] = TRUE;
          $allowComment[$key] = TRUE;

          // only reveal action if myStatus is false
          $revealAction[$key] = $myStatus[$key] === FALSE;
        }
      }

      // if $assigned_id is me
      // allow comment
      if ($uid == $assigned_id) {
        $allowComment[$key] = TRUE;
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
      'assign' => $newAssigns[0],
      'comments' => $comments,
      'allowComment' => $allowComment,
      'allowAction' => $allowAction,
      'myStatus' => $myStatus,
      'revealAction' => $revealAction
    ));
  }
  
  public function comment() {
    $uid = $this->session->userdata('user')['id'];
    $assignId = $this->input->post('assignId');
    $level = $this->input->post('level');
    $comment = $this->_filter($this->input->post('comment'));
    
    $data = array(
      'user_id' => $uid,
      'assign_id' => $assignId,
      'comment' => $comment,
      'level' => $level,
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
