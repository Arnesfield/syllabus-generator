<template>
<span v-if="items.length">
  <v-subheader class="mt-2 white">
    <slot name="title"/>
  </v-subheader>
  <div style="overflow-y: scroll;" :style="{ 'max-height': maxHeight }">
    <v-list class="pt-0 mt-0">
      <template v-for="(item, i) in items">
        <v-list-tile
          :ripple="!editable"
          :key="'tile-' + i"
          @click="() => {}"
          class="tile-select"
        >
          <v-layout class="full-height pl-3">
            <input
              type="checkbox"
              :value="item"
              :id="id + i"
              v-model="selected"
              :style="{ 'margin-top': !editable ? '18px' : '14px' }"
              class="mr-2"
            >
            <label
              class="clickable full-width full-height pr-3"
              style="display: block;"
              :for="!editable ? id + i : undefined"
              :class="{ 'primary--text': selectedCheck(item) }"
            >
              <slot name="item" :item="item" :index="i"/>
            </label>
          </v-layout>
        </v-list-tile>
      </template>
    </v-list>
  </div>
</span>
</template>

<script>
export default {
  name: 'select-list',
  props: {
    items: Array,
    value: Array,
    id: String,
    isSelected: Function,
    maxHeight: {
      type: String,
      default: '50vh'
    },
    editable: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    selected: []
  }),
  watch: {
    value: {
      deep: true,
      handler(e) {
        this.selected = e
      }
    },
    selected: {
      deep: true,
      handler(e) {
        this.$emit('input', e)
      }
    }
  },
  created() {
    this.selected = this.value
  },
  methods: {
    selectedCheck(item) {
      return this.isSelected(this.selected, item)
    }
  }
}
</script>
