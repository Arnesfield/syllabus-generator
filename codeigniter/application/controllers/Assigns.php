<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Assigns extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('assigns_model');
  }
  
  public function index() {
    $assigns = $this->assigns_model->get();

    if ($assigns) {
      // parse all "content"
      foreach ($assigns as $key => $assign) {
        $assigns[$key]['content'] = json_decode($assign['content'], TRUE);
      }

      $created_by = $this->assigns_model->_to_col($assigns, 'created_by');
      // get "content"
      $content = $this->assigns_model->_to_col($assigns, 'content');
      $assigned = $this->assigns_model->_to_col($content, 'assigned');
      $courses = $this->assigns_model->_to_col($content, 'course');
      $subs = $this->assigns_model->_to_col($content, 'sub');

      // get "course" data
      $courseData = $this->assigns_model->getCoursesWithIds($courses);

      // convert $courseData to id => value instead of index => value
      $newCourseData = array();
      foreach ($courseData as $key => $course) {
        $newCourseData[$course['id']] = $course;
      }

      // users included in this fetch
      $subUsers = array();

      // $subs is an array of array of objects
      foreach ($subs as $key => $sub) {
        // $sub is an array of objects
        // add id to $subUsers
        foreach ($sub as $subkey => $value) {
          array_push($subUsers, $value['id']);
        }
      }

      $listedUsers = array_unique(array_merge($assigned, $subUsers, $created_by));

      // get all users with ids from $listedUsers
      $assignedUsers = $this->assigns_model->getUsersWithIds($listedUsers);
      
      // now these users are in index => value
      // make these as uid => value
      $newAssignedUsers = array();
      foreach ($assignedUsers as $key => $user) {
        $newAssignedUsers[$user['id']] = $user;
      }

      // now based on that, put those users in the "assigned" in $assigns
      foreach ($assigns as $key => $assign) {
        // add the course info
        $assigns[$key]['content']['course'] = $newCourseData[$assign['content']['course']];
        $assigns[$key]['content']['assigned'] = $newAssignedUsers[$assign['content']['assigned']];
        $assigns[$key]['created_by'] = $newAssignedUsers[$assign['created_by']];

        // also set "user" prop in "sub"
        foreach ($assign['content']['sub'] as $subkey => $sub) {
          // check if user exists
          if (array_key_exists($sub['id'], $newAssignedUsers)) {
            $assigns[$key]['content']['sub'][$subkey]['user'] = $newAssignedUsers[$sub['id']];
          }
        }
      }
      
    }

    $this->_json(TRUE, 'assigns', $assigns);
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
