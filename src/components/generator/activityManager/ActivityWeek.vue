<template>
<tr>
  <td>
    <button type="button" @click="$emit('remove', index)">x</button>
    <button type="button" @click="$emit('add', index + 1)">+</button>
  </td>
  <td>
    <input type="number" v-model="act.noOfWeeks">
  </td>
</tr>
</template>

<script>
export default {
  name: 'activity-week',
  props: {
    index: Number,
    act: Object
  },

  watch: {
    act: {
      handler: function(to, from) {
        if (to !== null) {
          if (Number(to.noOfWeeks) <= 0) {
            this.act.noOfWeeks = 1
          }
        }
      },
      deep: true
    }
  }
}
</script>
