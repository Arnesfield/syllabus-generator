<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Logs extends MY_Custom_Controller {

  /**
   * Trail categories and their types
   * 
   * 1 - User logs
   *     0 - Out
   *     1 - In
   * 2 - Workflow logs
   *     1 - View
   *     2 - Approval
   *     3 - Disapproval
   * 3 - Manage Users
   *     1 - Add
   *     2 - Update
   *     3 - Delete
   *     4 - CSV
   * 4 - Manage Courses
   *     1 - Add
   *     2 - Update
   *     3 - Delete
   *     4 - CSV
   * 5 - Manage Curriculum
   *     1 - Add
   *     2 - Update
   *     3 - Delete
   * 6 - Manage Outcomes
   *     1 - Add
   *     2 - Update
   *     3 - Delete
   * 7 - Manage Books
   *     1 - Add
   *     2 - Update
   *     3 - Delete
   *     4 - CSV
   * 8 - Syllabus Content
   *     1 - Update
   * 9 - Grading System
   *     1 - Update
   * 10 - CLO Options
   *      1 - Update
   * 
   * 11 - Workflow
   *      1 - Create
   *      2 - Delete
   * 12 - Generator
   *      1 - Save
   *      2 - Submit
   * 13 - Course
   *      1 - View
   *      2 - Tree View
   * 14 - Syllabus
   *      1 - View
   */

  public function index() {
    $userId = $this->input->post('userId') ? $this->input->post('userId') : FALSE;

    $where = FALSE;

    if ($userId) {
      $where['au.user_id'] = $userId;
    }

    // get logs
    $logs = $this->logs_model->get($where);
    $this->_json(TRUE, 'logs', $logs);
  }

  public function detailed() {
    $item = $this->input->post('item');

    // get all if id is not 0
    $this->load->model(array(
      'users_model',
      'courses_model',
      'assigns_model',
      'curriculum_model',
      'outcomes_model',
      'syllabi_model',
      'books_model'
    ));

    if ($related_users = $this->users_model->get(array('id' => $item['related_user_id']))) {
      $item['related_user'] = $related_users[0];
    }

    if ($courses = $this->courses_model->getByQuery(FALSE, array('id' => $item['course_id']))) {
      $item['course'] = $courses[0];
    }

    if ($item['assign_id'] != 0 && $assigns = $this->assigns_model->get($item['assign_id'])) {
      $assigns = $this->_createAssigns($assigns);
      $item['assign'] = $assigns[0];
    }

    if ($curriculum = $this->curriculum_model->getByQuery(FALSE, array('id' => $item['curriculum_id']))) {
      $item['curriculum'] = $curriculum[0];
    }

    if ($outcomes = $this->outcomes_model->getByQuery(FALSE, array('id' => $item['outcome_id']))) {
      $item['outcome'] = $outcomes[0];
    }

    if ($syllabi = $this->syllabi_model->getByQuery(FALSE, array('id' => $item['syllabus_id']))) {
      $item['syllabus'] = $syllabi[0];
    }

    if ($books = $this->books_model->getByQuery(FALSE, array('id' => $item['book_id']))) {
      $item['book'] = $books[0];
    }

    $this->_json(TRUE, 'item', $item);
  }

  public function workflow() {
    $where = FALSE;
    if ($id = $this->input->post('id')) {
      $where = array('assign_id' => $id);
    }
    // get logs in workflow
    $logs = $this->logs_model->getWorkflow($where);
    $this->_json(TRUE, 'logs', $logs);
  }

  public function addWorkflow() {
    $aid = $this->input->post('id');
    $content = $this->input->post('content');
    $type = $this->input->post('type');

    $data = array(
      'assign_id' => $aid,
      'content' => $content,
      'type' => $type
    );

    $res = $this->_insertWorkflowLog($data);
    $this->_json($res);
  }

  public function user() {
    $search = $this->input->post('search')
      ? $this->_filter($this->input->post('search'))
      : FALSE;
    $limit = $this->_getPostLimit();
    
    $id = $this->input->post('id') ? $this->input->post('id') : FALSE;
    $monthly = $this->input->post('monthly') ? $this->input->post('monthly') : FALSE;
    $graph = $this->input->post('graph') ? $this->input->post('graph') : FALSE;
    $in = $this->input->post('in') ? $this->input->post('in') : FALSE;
    $out = $this->input->post('out') ? $this->input->post('out') : FALSE;

    $days = 0;
    $user = NULL;
    $where = array();
    $graphData = FALSE;

    // data
    $data = array();
    
    if ($id) {
      $where['u.id'] = $id;

      // get user too
      $this->load->model('users_model');
      $users = $this->users_model->get(array('id' => $id));
      if (!$users) {
        $this->_json(FALSE, 'users', $users);
      }
      $user = $users[0];

      // set user
      $data['user'] = $user;
    }
    if ($monthly) {
      // get 30 days
      $days = 30;
      $where['au.created_at >='] = strtotime("-$days day", strtotime('00:00:00'));
    }

    $logs = $this->logs_model->getUserLogs($search, $where, $limit);
    $data['logs'] = $logs;

    $self = $this;
    $createGraph = function($logs, $graph, $type, $field, $days) use ($self) {
      $data = array();
      
      $res = array_filter($logs, function($obj) use ($type) {
        return $obj['type'] == $type;
      });
      $data['log' . $field] = $res;
      
      // graph
      if ($graph) {
        $graphData = $self->createMagicDates($res, $days);
        $data['graphData' . $field] = $graphData;
      }

      return $data;
    };
    
    if ($in) {
      $logIns = $createGraph($logs, $graph, 1, 'Ins', $days);
      $data = array_merge($data, $logIns);
    }
    if ($out) {
      $logOuts = $createGraph($logs, $graph, 0, 'Outs', $days);
      $data = array_merge($data, $logOuts);
    }

    $this->_json(TRUE, $data);
  }

  // private
  // create Day# => ## of logs
  private function createMagicDates($views, $days = 30, $date_field = 'created_at') {
    $TODAY = strtotime('00:00:00');
    $myViews = array();
    for ($i = $days; $i >= 0; $i--) {
      $day = $i + 1;
      $dayAfter = $i;
      
      $day = strtotime("-$day day", $TODAY);
      $dayAfter = strtotime("-$dayAfter day", $TODAY);
      // $usersWhoAlreadyViewed = array();
      
      $thisDay = date('M j', $day);

      // make day to 0 if not existing yet
      if (!array_key_exists($thisDay, $myViews)) {
        $myViews[$thisDay] = 0;
      }

      foreach ($views as $key => $view) {
        // $userViewing = $view['viewer_id'];
        // if user already viewed, do not include
        // if (in_array($userViewing, $usersWhoAlreadyViewed)) {
        //   continue;
        // }

        // add that user to already viewed
        // array_push($usersWhoAlreadyViewed, $userViewing);

        $viewedDate = $view[$date_field];

        // do not add date if the user already viewed at that day
        if ($day <= $viewedDate && $viewedDate < $dayAfter) {
          $myViews[$thisDay] += 1;
        }
      }
    }
    return $myViews;
  }
}

?>
