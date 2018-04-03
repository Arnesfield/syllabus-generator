<template>
<v-container
  fluid
  class="pa-0"
  grid-list-lg
>
  <div class="pa-2">
    <v-list class="elevation-1 py-0" two-line>
      <v-list-tile
        ripple
        @click="add"
      >
        <v-list-tile-action class="thin-action">
          <v-tooltip top>
            <v-btn
              icon
              flat
              slot="activator"
              color="primary"
              @click="add"
            >
              <v-icon>grade</v-icon>
            </v-btn>
            <span>Add item</span>
          </v-tooltip>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title class="primary--text text--lighten-1">
            <template>Grading System</template>
          </v-list-tile-title>
          <v-list-tile-sub-title>
            <template>Click to add another grade</template>
          </v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>

      <!-- show suggested here -->
      <template v-if="suggested && (!grading || notLatest())">
        <v-divider/>
        <v-list-tile
          ripple
          @click="setSuggested"
        >
          <v-list-tile-action class="thin-action">
            <v-tooltip top>
              <v-btn
                icon
                flat
                slot="activator"
                color="warning"
                @click="setSuggested"
              >
                <v-icon>new_releases</v-icon>
              </v-btn>
              <span>Select suggested</span>
            </v-tooltip>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title
              class="warning--text"
              v-text="'Latest grading system'"
            />
            <v-list-tile-sub-title>
              <span>Use the latest grading system. Last updated in</span>
              <strong v-text="$moment.unix(suggestedDate).format('MMMM DD, YYYY h:mmA')"/>.
            </v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

    </v-list>
  </div>

  <template v-if="grading.length">
    <v-divider class="my-2"/>
    <v-layout row wrap>
      <v-flex
        xs12
        sm6
        :key="i"
        v-for="(item, i) in grading"
      >
        <simple-title-text-card
          v-model="grading[i]"
          :index="i"
          @remove="remove"
          icon="grade"
          removable
          placeholder="Enter label (e.g. Midterm Exam, Final Exam)"
        />
      </v-flex>
    </v-layout>
  </template>

  <v-layout class="px-2 mb-5">
    <v-spacer v-if="grading.length == 0"/>
    <v-btn
      color="primary lighten-1"
      @click="add"
    >
      <v-icon>grade</v-icon>&nbsp;
      <span>Add Grading</span>
    </v-btn>
  </v-layout>

</v-container>
</template>

<script>
import SimpleTitleTextCard from '@/include/SimpleTitleTextCard'

export default {
  name: 'grading-system',
  components: {
    SimpleTitleTextCard
  },
  props: {
    value: Array
  },
  data: () => ({
    url: '/settings/grading_system',
    grading: [],
    suggested: [],
    suggestedDate: null,
    loading: false
  }),
  watch: {
    value(e) {
      this.grading = e
    },
    grading(e) {
      this.$emit('input', e)
    }
  },
  created() {
    this.grading = this.value
    this.fetch()
  },

  methods: {
    notLatest() {
      return this.grading.length == 0 || !this.grading.every((e, i) => {
        return Boolean(this.suggested[i])
          && this.suggested[i].label == e.label
          && this.suggested[i].text == e.text
      })
    },

    add() {
      this.grading.push({
        label: null,
        text: 'Enter grading here'
      })
    },
    remove(i) {
      this.grading.splice(i, 1)
    },

    setSuggested() {
      this.grading = JSON.parse(JSON.stringify(this.suggested))
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        let grading = res.data.gradingSystem
        // alert(this.grading.length)
        this.grading = this.grading.length ? this.grading : grading.content
        this.suggested = JSON.parse(JSON.stringify(grading.content))
        this.suggestedDate = grading.updated_at
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
  },
