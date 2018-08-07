<template>
<div class="scrollable-x elevation-1">
  <table border="1" class="syllabus-tbl table striped">
    <tr>
      <th class="emphasize" colspan="3">CSV Properties List</th>
    </tr>
    <tr>
      <th>Name/Column</th>
      <th>Type</th>
      <th>Description</th>
    </tr>
    <tr
      :key="i"
      v-for="(v, i) in value"
      class="center-td-content"
    >
      <td>
        <div
          class="mono"
          v-if="v.name"
        >
          <template>{{ v.name }}</template><span
            v-if="v.required"
            class="red--text"
          >*</span>
        </div>
      </td>
      <td>
        <code
          v-if="v.type"
          v-text="v.type"
        />
      </td>
      <td>
        <div
          v-if="v.text"
          v-text="v.text"
        />
      </td>
    </tr>
  </table>
</div>
</template>

<script>
export default {
  name: 'csv-prop-list',
  props: {
    value: Array
  }
}
</script>

<style scoped>
.center-td-content td {
  text-align: center;
}

.striped tr:nth-child(odd) {
  background-color: #fafafa
}

.emphasize {
  background-color: rgba(0,0,0,0.08);
}
</style>
