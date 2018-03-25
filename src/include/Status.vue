<template>
<v-tooltip top>
  <v-btn icon slot="activator">
    <v-icon color="error" v-if="status(0)">cancel</v-icon>
    <v-icon color="success" v-else-if="status(1)">check_circle</v-icon>
    <v-icon color="accent" v-else-if="status(2)">indeterminate_check_box</v-icon>
    <v-icon color="grey" v-else-if="status(3)">block</v-icon>
  </v-btn>
  <span
    :key="i"
    v-for="i in 4"
    v-if="status(i-1)"
    v-html="msg[i-1]"
  ></span>
</v-tooltip>
</template>

<script>
export default {
  name: 'status',
  props: {
    item: {
      type: Object,
      required: true
    },
    msg: {
      type: Object,
      default: () => ({
        0: 'Disapproved',
        1: 'Approved',
        2: 'Undecided',
        3: 'Not yet submitted'
      })
    }
  },

  methods: {
    status(n) {
      return Number(this.item.status) == n
    }
  }
}
</script>
