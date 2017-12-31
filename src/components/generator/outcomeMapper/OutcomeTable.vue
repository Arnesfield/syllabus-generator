<template>
<div>
  <table border="1">
    <tr>
      <th>&nbsp;</th>
      <th style="width: 50%">{{ title }}</th>
      <th style="width: 50%" :colspan="supporting.length">{{ supportingTitle }}</th>
    </tr>
    <tr>
      <td>
        <button @click="add(0)">+</button>
      </td>
      <td>&nbsp;</td>
      <td :key="po.label" v-for="po in supporting"
        style="text-align: center">{{ po.label }}</td>
    </tr>
    <tr :key="clo.label" v-for="(clo, cloIndex) in main">
      <td>
        <button @click="remove(cloIndex)">x</button>
        <button @click="add(cloIndex + 1)">+</button>
      </td>
      <td :ref="'content-' + clo.label">
        <span>{{ clo.label + '. ' }}</span>
        <textarea class="textarea" v-model="clo.content"></textarea>
      </td>
      <td
        @mouseover="boxOver(clo.label, po.label)"
        @mouseout="boxOut(clo.label, po.label)"
        @click="boxClick(cloIndex, po.label)"
        :ref="'box-' + clo.label + '-' + po.label"
        :key="po.label"
        v-for="po in supporting"
        style="text-align: center">
        <template v-if="clo[supportingFieldName].indexOf(po.label) > -1">x</template>
        <template v-else>&nbsp;</template>
      </td>
    </tr>
  </table>
</div>
</template>

<script>
export default {
  name: 'outcome-table',
  props: {
    main: Object,
    supporting: Object,
    supportingFieldName: String,
    title: String,
    supportingTitle: String
  },

  methods: {
    boxOver(cloLabel, poLabel) {
      // sample style
      // this.$refs['po-' + poLabel][0].style.backgroundColor = '#ccc'
      this.$refs['box-' + cloLabel + '-' + poLabel][0].style.backgroundColor = '#ccc'
      this.$emit('over', poLabel)
    },

    boxOut(cloLabel, poLabel) {
      // sample style
      // this.$refs['po-' + poLabel][0].style.backgroundColor = null
      this.$refs['box-' + cloLabel + '-' + poLabel][0].style.backgroundColor = null
      this.$emit('out', poLabel)
    },

    boxClick(index, label) {
      let arr = this.main[index][this.supportingFieldName]
      // if label exists in arr, remove it
      if (arr.indexOf(label) > -1) {
        var set = new Set(arr)
        set.delete(label)
      }
      else {
        arr.push(label)
        var set = new Set(arr)
      }
      this.main[index][this.supportingFieldName] = Array.from(set)
    },

    add(index) {
      let obj = {
        label: index + 1,
        content: ''
      }
      obj[this.supportingFieldName] = []
      this.main.splice(index, 0, obj)
      this._updateLabels()
    },
    remove(index) {
      this.main.splice(index, 1)
      this._updateLabels()
    },

    _updateLabels() {
      this.main.forEach((e, i) => {
        e.label = i + 1
      })
    }
  }
}
</script>

<style scoped>
.textarea {
  width: 95%;
  min-width: 95%;
  max-width: 95%;
  min-height: 32px;
  max-height: 64px;
  resize: vertical;
  background: none;
}
</style>
