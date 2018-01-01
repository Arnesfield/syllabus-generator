<template>
<div>
  <div>
    From:
    <template v-if="index > 0">
      <select v-model="week.from">
        <option :value="n" v-for="n in Number(totalWeeks)" :key="n">{{ n }}</option>
      </select>
    </template>
    <template v-else>
      {{ week.from }}
    </template>
  </div>
  <div>
    Until:
    <select v-model="week.until" @change="onChangeUntil">
      <option :value="n" v-for="n in Number(totalWeeks)" :key="n">{{ n }}</option>
    </select>
  </div>
</div>
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
      this.$emit('change-until', true)
    }
  }
}
</script>
