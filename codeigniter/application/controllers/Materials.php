<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Materials extends MY_Custom_Controller {

  public function __construct() {
    parent::__construct();
    $this->load->model('materials_model');
    $this->load->model('fields_model');
  }
  
  public function index() {
    $search = $this->_filter($this->input->post('search'));
    $materials = $this->materials_model->getByQuery($search);
    $materials = $this->materials_model->_to_col($materials, 'name');
    $this->_json(TRUE, 'materials', $materials);
  }

  public function suggest() {
    $course_id = $this->input->post('courseId');
    $book_ids = $this->input->post('bookIds') ? $this->input->post('bookIds') : FALSE;
    $topic_ids = $this->input->post('topicIds') ? $this->input->post('topicIds') : FALSE;
    $curriculum_id = $this->input->post('curriculumId');
    $limit = $this->input->post('limit');

    // get fields of course
    // get fields of books selected
    // get fields of materials

    $cFields = $this->fields_model->getFieldsByCourseId($course_id);
    $bFields = $this->fields_model->getFieldsByBookIds($book_ids);
    $tMaterials = $this->fields_model->getMaterialsByTopicIds($topic_ids);
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
    $materialsArr = array();
    if (is_array($tMaterials)) {
      foreach ($tMaterials as $material) {
        array_push($materialsArr, $material['material_id']);
      }
    }

    $materials = $this->materials_model->getRelatedMaterialsWithFields($fields, $limit, $materialsArr);
    $materials = $this->materials_model->_to_col($materials, 'name');
    $this->_json(TRUE, 'materials', $materials);
  }
}

?>
