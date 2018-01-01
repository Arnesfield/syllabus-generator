<template>
<tr>
  <td>
    <button @click="$emit('remove', index)">x</button>
    <button @click="$emit('add', index + 1)">+</button>
  </td>

  <td>

    <div>From: {{ week.from }}</div>
    <div>
      Until:
      <template v-if="index < weeks.length - 1">
        <select v-model="week.until" @change="onChangeUntil">
          <option :value="n" v-for="n in Number(totalWeeks)-1" :key="n">{{ n }}</option>
        </select>
      </template>
      <template v-else>
        {{ week.until }}
      </template>
    </div>

  </td>
</tr>
</template>

<script>
export default {
  name: 'activity-week',
  props: {
    week: Object,
    weeks: Object,
    totalWeeks: Number,
    index: Number
  },

  methods: {
    onChangeUntil() {
      this.$emit('change-until')
    }
  }
}
</script>
