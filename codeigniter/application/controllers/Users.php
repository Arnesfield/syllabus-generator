<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('users_model');
  }
  
  public function index() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : FALSE;
    $id = $this->input->post('id') ? $this->input->post('id') : FALSE;
    $auth = $this->input->post('auth') ? $this->input->post('auth') : FALSE;
    $limit = $this->_getPostLimit();
    $where = array();

    if ($id) {
      $where['id'] = $id;
    }

    $users = $this->users_model->getByQuery($search, $where, $auth, $limit);
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

    if ($res) {
      $this->_insert_trail('manage_users', 4);
    }

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

    if ($res) {
      $this->_insert_trail('manage_users', 3, array(
        'related_user_id' => $id,
        'content' => "Deleted User $id"
      ));
    }

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

    $profile = $this->_filter_bool('profile');

    $fname = $this->input->post('fname');
    $mname = $this->input->post('mname');
    $lname = $this->input->post('lname');

    if (!$profile) {
      $username = $this->input->post('username');
      $title = $this->input->post('title');
      $weight = $this->input->post('weight');
      $status = $this->input->post('status');

      $tags = $this->input->post('tags');
      $auth = $this->input->post('auth');
    }

    // options
    $mode = $this->input->post('mode');
    $alsoPassword = $this->_filter_bool('alsoPassword');
    $removeImage = $this->_filter_bool('removeImage');

    $TIME = time();
    
    $data = array(
      'fname' => $fname,
      'mname' => $mname,
      'lname' => $lname,
      'updated_at' => $TIME
    );

    if (!$profile) {
      $profile_data = array(
        // fields admin can change
        'username' => $username,
        'title' => $title,
        'weight' => $weight,
        'tags' => $tags,
        'auth' => $auth,
        'status' => $status
      );

      $data = array_merge($data, $profile_data);
    }
    
    if ($alsoPassword === TRUE) {
      if ($profile) {
        $currentPassword = $this->input->post('currentPassword');
        // check if current password is correct
        $id = $this->input->post('id');
        if ($users = $this->users_model->get(array('id' => $id))) {
          $user = $users[0];
          $currentPassHash = $user['password'];
          
          if (!password_verify($currentPassword, $currentPassHash)) {
            $this->_json(FALSE, 'error', 'Password incorrect.');
          }
        } else {
          $this->_json(FALSE);
        }
      }

      $password = $this->input->post('password');
      $data['password'] = password_hash($password, PASSWORD_BCRYPT);
    }

    // change img src if yeah you get it
    if ($img_src !== FALSE) {
      $data['img_src'] = $img_src;
    }

    // BUT, if remove, just empty it hehe
    if ($removeImage) {
      $data['img_src'] = '';
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
      // insert trail
      $trail = array();
      if ($mode == 'add') {
        $trail['type'] = 1;
        $trail['data'] = array();
      } else if ($mode == 'edit') {
        $trail['type'] = 2;
        $trail['data'] = array(
          'related_user_id' => $id,
          'content' => "Updated User $id"
        );
      } else {
        $trail = FALSE;
      }

      if ($trail !== FALSE) {
        if ($profile) {
          $this->_insert_trail('profile', 1, $trail['data']);
        } else {
          $this->_insert_trail('manage_users', $trail['type'], $trail['data']);
        }
      }

      // insert new tags
      if (!$profile) {
        $this->load->model('tags_model');
        $this->tags_model->insertMultiple(json_decode($tags, TRUE));
      }

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
