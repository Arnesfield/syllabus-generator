<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Assigns extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('assigns_model');
  }
  
  public function index() {
    $assigns = $this->assigns_model->get();
    $assigns = $this->createAssigns($assigns);
    $this->_json(TRUE, 'assigns', $assigns);
  }
  
  public function my() {
    $id = $this->session->userdata('user')['id'];
    $assigns = $this->assigns_model->getAssigned($id);
    $assigns = $this->createAssigns($assigns);
    $this->_json(TRUE, 'assigns', $assigns);
  }

  public function approve_reject() {
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

  private function createAssigns($assigns) {
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

    return $assigns;
  }
}

?>
