<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Comments extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('comments_model');
  }
  
  public function index() {
    $assignId = $this->input->post('assignId');
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

    $this->_json(TRUE, 'comments', $comments);
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
