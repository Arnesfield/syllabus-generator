<template>
<div v-if="syllabus">
  <h4>Instructional Materials</h4>
  <div>
    <textarea v-model="text" id="used-materials" cols="30" rows="5"
      placeholder="Enter instructional material"></textarea>
    <button @click="addMaterial">Add Material</button>
  </div>

  <div v-if="materials.length">
    <ul :key="index" v-for="(material, index) in materials">
      <li>
        {{ material }}
        <button @click="materials.splice(index, 1)">Remove</button>
      </li>
    </ul>
  </div>
</div>
</template>

<script>
export default {
  name: 'used-materials-manager',
  props: {
    syllabus: Object
  },
  data: () => ({
    text: '',
    materials: []
  }),

  methods: {
    addMaterial() {
      if (!this.text) return;
      this.materials.push(this.text)
      this.text = ''
    }
  }
}
</script>
