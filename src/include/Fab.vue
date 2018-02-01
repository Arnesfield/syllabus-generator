<template>
<v-speed-dial
  v-model="$bus.fab.model"
  :value="fab !== null"
  :open-on-hover="true"
  fixed
  bottom
  right>
  <template v-if="fab !== null">
    <v-btn
      slot="activator"
      v-model="$bus.fab.model"
      :color="fab.color"
      dark
      fab>
      <v-icon>{{ fab.before }}</v-icon>
      <v-icon>{{ fab.after }}</v-icon>
    </v-btn>
    <template v-for="(btn, i) in fab.btns">
      <v-tooltip :key="i" left>
        <v-btn
          slot="activator"
          :to="typeof btn.to === 'string' ? btn.to : undefined"
          @click="typeof btn.cb === 'string' ? $bus.$emit(btn.cb, $event) : undefined"
          :color="typeof btn.color === 'string' ? btn.color : undefined"
          :dark="typeof btn.dark === 'boolean' ? btn.dark : false"
          small
          fab>
          <v-icon>{{ btn.icon }}</v-icon>
        </v-btn>
        <span>{{ btn.tip }}</span>
      </v-tooltip>
    </template>
  </template>
</v-speed-dial>
</template>

<script>
export default {
  name: 'fab',
  props: {
    currRoute: String
  },
  computed: {
    fab() {
      return this.$bus.fabProp(this.currRoute)
    }
  }
}
</script>
