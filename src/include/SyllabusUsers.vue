<template>
<div v-if="users">
  <template v-for="(by, i) in users">
    <template v-if="by.user">
      <div
        :key="'name-' + i"
        class="text-xs-center underline"
        v-text="$wrap.fullname(by.user)"
      />
      <div
        :key="'position-' + i"
        class="text-xs-center"
        v-text="by.user.title"
      />
    </template>

    <template v-if="users.length-1 != i">
      <br :key="'br1-' + i">
      <br :key="'br2-' + i">
      <br :key="'br3-' + i">
    </template>

  </template>
</div>
</template>

<script>
import find from 'lodash/find'
import filter from 'lodash/filter'

export default {
  name: 'syllabus-users',
  props: {
    levels: Array,
    filter: {
      type: Function,
      default: (e) => e.status == 1
    }
  },
  computed: {
    users() {
      return this.levels.reduce((filtered, level) => {
        // these are users who approved the syllabus in a certain level
        let users = filter(level, this.filter)
        // add them to filtered if id per user does not exist in filtered yet
        let validUsers = users.filter(user => {
          // if user id exists, return false
          return !find(filtered, { id: user.id })
        })
        return filtered.concat(validUsers)
      }, [])
    }
  }
}
</script>
