<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Outcomes extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('outcomes_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $type = $this->input->post('type');
    $search = strip_tags(trim(addslashes($this->input->post('search'))));
    $outcomes = $this->outcomes_model->getByQuery($type, $search);

    // change outcomes to string
    if ($outcomes) {
      foreach ($outcomes as $key => $outcome) {
        $outcomes[$key] = $outcome['content'];
      }
    }

    $this->_json('outcomes', $outcomes);
  }

  public function suggest() {
    $type = $this->input->post('type');
    $course_id = $this->input->post('courseId');
    $book_ids = $this->input->post('bookIds') ? $this->input->post('bookIds') : FALSE;
    $topic_ids = $this->input->post('topicIds') ? $this->input->post('topicIds') : FALSE;
    $year = $this->input->post('curriculumYear');
    $limit = $this->input->post('limit');

    // clo content only when suggesting ilos
    $clo_content = $this->input->post('cloContent') ? $this->input->post('cloContent') : FALSE;
    
    // type 1 = clo
    // type 2 = ilo
    // type 3 = tla faculty
    // type 4 = tla student

    // get fields of course
    // get fields of books selected
    // get fields of outcomes
    // for ilos, get ilos using clos

    $cFields = $this->fields_model->getFieldsByCourseId($course_id);
    $bFields = $this->fields_model->getFieldsByBookIds($book_ids);
    $tOutcomes = $this->fields_model->getOutcomesByTopicIds($topic_ids, $type);
    $ilosFromClos = $this->outcomes_model->getILOsFromCLOs($clo_content, $limit);

    $fields = array();
    if (is_array($cFields)) {
      foreach ($cFields as $field) {
        array_push($fields, $field['field_id']);
      }
    }
    if (is_array($bFields)) {
      foreach ($bFields as $field) {
        // if not yet in array, include it
        if (!in_array($field['field_id'], $fields)) {
          array_push($fields, $field['field_id']);
        }
      }
    }

    $outcomesArr = array();
    if (is_array($tOutcomes)) {
      foreach ($tOutcomes as $outcome) {
        array_push($outcomesArr, $outcome['outcome_id']);
      }
    }
    if (is_array($ilosFromClos)) {
      foreach ($ilosFromClos as $outcome) {
        // if not yet in array, include it
        if (!in_array($outcome['outcome_id'], $outcomesArr)) {
          array_push($outcomesArr, $outcome['outcome_id']);
        }
      }
    }

    $outcomes = $this->outcomes_model->getRelatedOutcomesWithFields($fields, $type, $limit, $outcomesArr);

    // change outcomes to string
    if ($outcomes) {
      foreach ($outcomes as $key => $outcome) {
        $outcomes[$key] = $outcome['content'];
      }
    }

    $this->_json('outcomes', $outcomes);
  }
}

?>
