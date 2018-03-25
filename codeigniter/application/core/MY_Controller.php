<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class MY_Controller extends CI_Controller {
  public function __construct() {
    parent::__construct();
  }
}

/**
 * View Controller
 * 
 * Extend to this controller to load views.
 */
class MY_View_Controller extends MY_Controller {
  
  /**
   * Loads URL helper.
   */
  public function __construct() {
    parent::__construct();
    $this->load->helper('url');
  }

  /**
   * Loads a view in the views/ directory.
   *
   * @param mixed $view Name of the view or an array of names of the views in views/ to be loaded
   * @param mixed $data A string title for the view or an associative array to be passed in the $view
   * @param boolean $view_only Loads the $view only; otherwise, header and footer in views/templates/ are also loaded
   * @return void
   */
  protected function _view($view = 'pages/home', $data = array(), $view_only = FALSE) {
    $header = 'templates/header';
    $footer = 'templates/footer';

    // create array of views
    $views = array();

    // add header
    if (!$view_only) {
      array_push($views, $header);
    }

    // turn $view into array
    if (!is_array($title = $view)) {
      $view = array($view);
    }
    // add $view
    $views = array_merge($views, $view);

    // add footer
    if (!$view_only) {
      array_push($views, $footer);
    }

    // turn $data into array with title
    if (is_string($data)) {
      $data = array('title' => $data);
    }

    // set title if data is null or empty
    if (empty($data) && is_string($title)) {
      $data['title'] = ucfirst(basename($title));
    }

    // load $views
    foreach ($views as $index => $view) {
      // check if page exists
      if (!file_exists(APPPATH . 'views/' . $view . '.php')) {
        show_404();
      }
      // load view
      $this->load->view($view, $index === 0 ? $data : NULL);
    }

  }
}

/**
 * My custom controller
 * 
 * Extends MY_View_Controller
 */
class MY_Custom_Controller extends MY_View_Controller {
  public function __construct() {
    parent::__construct();
    // prevent access if not post request
    if ($this->input->method(TRUE) !== 'POST') {
      $this->_redirect();
    }
    // load lib
    $this->load->library('session');
    $this->load->model('logs_model');
  }

  public function _filter($str) {
    return strip_tags(trim(addslashes($str)));
  }

  public function _redirect($to = '../#/error') {
    redirect(base_url($to));
  }

  public function _json($success, $arr = array(), $val = NULL) {
    // if $arr is string, make it an array with $val
    if (is_string($arr)) {
      $arr = array($arr => $val);
    }

    $master = array_merge($arr, array('success' => $success));

    echo json_encode($master);
    exit;
  }

  public function _createAssigns($assigns) {
    if ($assigns) {
      $all_user_ids = array();
      $all_course_ids = array();

      foreach ($assigns as $key => $assign) {
        $content = $assigns[$key]['content'] = json_decode($assign['content'], TRUE);

        $created_by = $assign['created_by'];
        $assigned_id = $content['assigned']['id'];
        
        // just push and we'll remove duplicates later
        array_push($all_user_ids, $created_by);
        array_push($all_user_ids, $assigned_id);

        $levels = $content['levels'];
        foreach ($levels as $key => $level) {
          // $level is an array of objects
          foreach ($level as $lvl_key => $user) {
            array_push($all_user_ids, $user['id']);
          }
        }

        // get the course
        $course_id = $content['course'];

        array_push($all_course_ids, $course_id);
      }

      $all_user_ids = array_unique($all_user_ids);
      $all_course_ids = array_unique($all_course_ids);

      // fetch from db
      $all_users = $this->assigns_model->getUsersWithIds($all_user_ids);
      $all_courses = $this->assigns_model->getCoursesWithIds($all_course_ids);

      // yahoo we can now edit the assigns
      // create array of id => value users and courses
      $actual_users = array();
      foreach ($all_users as $key => $user) {
        $actual_users[$user['id']] = $user;
      }

      $actual_courses = array();
      foreach ($all_courses as $key => $course) {
        $actual_courses[$course['id']] = $course;
      }

      // loop through assigns again and set those values, baby
      foreach ($assigns as $key => $assign) {
        // set the info
        $assigns[$key]['content']['assigned']['user'] = $actual_users[$assign['content']['assigned']['id']];
        $assigns[$key]['content']['course'] = $actual_courses[$assign['content']['course']];
        $assigns[$key]['created_by'] = $actual_users[$assign['created_by']];

        // loop through levels
        foreach ($assign['content']['levels'] as $lvl_key => $level) {
          // loop through users
          foreach ($level as $u_key => $user) {
            $assigns[$key]['content']['levels'][$lvl_key][$u_key]['user'] = $actual_users[$user['id']];
          }
        }
      }
    }

    // get all user ids and put all dat in an array
    // using dat array, get all users
    // assign those users in assigned prop and all levels
    // same with courses

    // sample content structure
    // content = {
    //   assigned: { id, status },
    //   course: id,
    //   level: [
    //     [{ id, status }, ...],
    //     ...
    //   ]
    // }

    return $assigns;
  }

  public function _insertWorkflowLog($data) {
    $data['user_id'] = $this->session->userdata('user')['id'];
    $data['created_at'] = time();
    $data['status'] = 1;
    return $this->logs_model->insertWorkflow($data);
  }
}

?>
