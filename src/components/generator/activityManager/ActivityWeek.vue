<template>
<tr>
  <td>
    <button type="button" @click="$emit('remove', index)">x</button>
    <button type="button" @click="$emit('add', index + 1)">+</button>
  </td>
  <td>
    <input type="number" v-model="act.noOfWeeks">
  </td>
  <template v-if="iloLength">
    <td
      class="t-center"
      @mouseover="over(ilo - 1, $event)"
      @mouseout="out(ilo - 1, $event)"
      @click="click(ilo - 1)"
      v-for="ilo in iloLength"
      :key="ilo">
      <template v-if="typeof act.iloMap !== 'undefined' && act.iloMap.indexOf(ilo - 1) > -1"
        >x</template>
      <template v-else>&nbsp;</template>
    </td>
  </template>
  <td v-else>&nbsp;</td>
</tr>
</template>

<script>
import moveArray from '@/assets/js/moveArray'

export default {
  name: 'activity-week',
  props: {
    act: Object,
    syllabus: Object,
    bus: Object,
    index: Number
  },

  computed: {
    iloLength() {
      return this.syllabus.content.intendedLearningOutcomes.length
    }
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
  },

  created() {
    if (this.bus !== null) {
      this.bus.$on('ilo-updated', this.onILOUpdated)
    }
  },

  methods: {
    over(i, e) {
      e.target.classList.add('outcome-highlighted')
      this.$emit('highlighted', i)
    },
    out(i, e) {
      e.target.classList.remove('outcome-highlighted')
      this.$emit('highlighted', -1)
    },
    click(i) {
      if (typeof this.act.iloMap === 'undefined') {
        this.$set(this.act, 'iloMap', [])
      }

      let set = new Set(this.act.iloMap)
      // if existing, remove it
      set.has(i) ? set.delete(i) : set.add(i)
      this.act.iloMap = Array.from(set)
    },

    onILOUpdated(i, n) {
      this.act.iloMap = moveArray(this.act.iloMap, i, n)
    }
  }
}
</script>
