<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('users_model');
  }
  
  public function index() {
    $users = $this->users_model->get();
    $users = $this->_formatUsers($users, TRUE);
    $this->_json(TRUE, array(
      'users' => $users,
      'currId' => $this->session->userdata('user')['id']
    ));
  }

  public function search() {
    $search = $this->_filter($this->input->post('search'));
    $users = $this->users_model->getByQuery($search);
    $users = $this->_formatUsers($users, TRUE);
    $this->_json(TRUE, 'users', $users);
  }

  // admin

  public function addCsv() {
    $users = $this->input->post('users');
    // foreach user, add auth
    foreach ($users as $key => $user) {
      $users[$key]['auth'] = json_encode(array($user['type']));
      $time = time();
      if (!isset($user['created_at'])) {
        $users[$key]['created_at'] = $time;
      }
      if (!isset($user['updated_at'])) {
        $users[$key]['updated_at'] = $time;
      }
    }
    $res = $this->users_model->insertMultiple($users);
    $this->_json($res);
  }

  public function delete() {
    $id = $this->input->post('id');
    $data = array(
      'status' => -1,
      'updated_at' => time()
    );
    $where = array('id' => $id);
    $res = $this->users_model->update($data, $where);
    $this->_json($res);
  }

  public function manage() {
    $img_src = FALSE;

    // upload image first
    // check if image exists
    if ($_FILES && $_FILES['file']) {
      $res = $this->_uploadFile();
      if (!$res['success']) {
        $this->_json(FALSE, 'error', strip_tags($res['error']));
      } else {
        $img_src = $res['data']['file_name'];
      }
    }

    $fname = $this->input->post('fname');
    $mname = $this->input->post('mname');
    $lname = $this->input->post('lname');
    $username = $this->input->post('username');
    $title = $this->input->post('title');
    $weight = $this->input->post('weight');
    $status = $this->input->post('status');

    $tags = $this->input->post('tags');
    $auth = $this->input->post('auth');

    // options
    $mode = $this->input->post('mode');
    $alsoPassword = $this->input->post('alsoPassword');

    $TIME = time();
    
    $data = array(
      'fname' => $fname,
      'mname' => $mname,
      'lname' => $lname,
      'username' => $username,
      'title' => $title,
      'weight' => $weight,
      'updated_at' => $TIME,
      'tags' => $tags,
      'auth' => $auth,
      'status' => $status
    );
    
    $alsoPassword = filter_var($alsoPassword, FILTER_VALIDATE_BOOLEAN);
    if ($alsoPassword === TRUE) {
      $password = $this->input->post('password');
      $data['password'] = password_hash($password, PASSWORD_BCRYPT);
    }

    // change img src if yeah you get it
    if ($img_src !== FALSE) {
      $data['img_src'] = $img_src;
    }
    
    $res = FALSE;
    if ($mode == 'add') {
      $data['created_at'] = $TIME;
      $res = $this->users_model->insert($data);
    } else if ($mode == 'edit') {
      $id = $this->input->post('id');
      $res = $this->users_model->update($data, array('id' => $id));
    }

    $updatedSess = FALSE;
    if ($res) {
      // insert new tags
      $this->load->model('tags_model');
      $this->tags_model->insertMultiple(json_decode($tags, TRUE));

      // update session if id same as sess id
      $uid = $this->session->userdata('user')['id'];
      if (isset($id) && $id == $uid) {
        $this->_updateSess();
        $updatedSess = TRUE;
      }
    }

    $this->_json($res, array(
      'sess' => $updatedSess
    ));
  }
}

?>
