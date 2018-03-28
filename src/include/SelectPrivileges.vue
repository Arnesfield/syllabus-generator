<template>
<v-select
  v-model="privileges"
  :label="label"
  :placeholder="placeholder"
  :color="color"
  chips
  multiple
  deletable-chips
  autocomplete
  :disabled="disabled"
  return-object
  prepend-icon="verified_user"
  :loading="loading"
  :items="items"
  :required="required"
  :rules="[ (required ? $fRule('requiredArray') : () => true) ]"
>

  <template slot="selection" slot-scope="data">
    <v-chip
      close
      @input="data.parent.selectItem(data.item)"
      :selected="data.selected"
      class="chip--select-multi"
      :key="JSON.stringify(data.item)"
    >
      <v-icon
        small
        :color="data.item.color"
      >{{ data.item.icon }}</v-icon>
      {{ data.item.text }}
    </v-chip>
  </template>

  <template slot="item" slot-scope="data">
    <v-list-tile-avatar>
      <v-icon
        :color="data.item.color"
      >{{ data.item.icon }}</v-icon>
    </v-list-tile-avatar>
    <v-list-tile-content>
      <v-list-tile-title v-text="data.item.text"></v-list-tile-title>
    </v-list-tile-content>
    <v-list-tile-action>
      <v-tooltip left>
        <v-btn
          icon
          dark
          slot="activator"
        >
          <v-icon color="grey">info_outline</v-icon>
        </v-btn>
        <span v-html="data.item.description"/>
      </v-tooltip>
    </v-list-tile-action>
  </template>
</v-select>
</template>

<script>
import find from 'lodash/find'

export default {
  name: 'select-tags',
  props: {
    value: Array,
    label: {
      type: String,
      default: 'Privileges'
    },
    placeholder: {
      type: String,
      default: undefined
    },
    color: {
      type: String,
      default: 'primary'
    },
    disabled: Boolean,
    required: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    privileges: [],
    items: [
      {
        text: 'Admin', icon: 'verified_user', color: 'blue', value: 1,
        description: 'Access to management'
      },
      {
        text: 'Faculty', icon: 'account_circle', color: 'primary lighten-1', value: 3,
        description: 'Basic functionality'
      },
      {
        text: 'Create workflow', icon: 'group_work', color: 'accent', value: 4,
        description: 'Able to create workflow assignments'
      },
      {
        text: 'Approval', icon: 'spellcheck', color: 'purple', value: 5,
        description: 'Able to approve or disapprove syllabus'
      },
      {
        text: 'Librarian', icon: 'local_library', color: 'warning', value: 6,
        description: 'Add books functionality'
      }
    ],
    loading: false
  }),
  watch: {
    privileges(e) {
      this.$emit('input', e)
    },
    value(e) {
      this.privileges = this.value
    }
  },
  created() {
    this.privileges = this.value
  },

  methods: {
    formatRaw(raw) {
      let selectable = []

      if (typeof raw === 'object' && raw.constructor.name === 'Array') {
        raw.forEach(e => {
          // e is number
          // find that number in value
          let privilege = find(this.items, { value: e })
          if (privilege) {
            selectable.push(privilege)
          }
        })
      }

      return selectable
    }
  }
}
</script>
