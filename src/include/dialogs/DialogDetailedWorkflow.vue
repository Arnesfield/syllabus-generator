<template>
<v-dialog
  v-model="show"
  width="680"
  :persistent="loading"
  transition="fade-transition"
  scrollable
>
  <v-card v-if="assign">
    <v-card-title primary-title>
      <div>
        <div class="headline">{{ course().code }}</div>
        <div class="subheading">{{ course().title }}</div>
      </div>
    </v-card-title>

    <v-card-text class="pt-0">

      <v-layout row wrap>
        <v-flex xs12 sm6 class="pr-4">
          <div class="body-1 grey--text">Workflow by</div>
          <v-list>
            <v-list-tile @click="() => {}">
              <v-list-tile-action>
                <icon-img
                  :item="assign.created_by"
                  color="primary"
                  size="32"
                  caption
                />
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>
                  {{ $wrap.fullname(assign.created_by) }}
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>

          <v-list dense class="mb-3">

            <v-list-tile
              ripple
              v-if="assign.status != 3"
              :to="'/syllabus/' + assign.id"
            >
              <v-list-tile-action class="thin-action">
                <v-tooltip top>
                  <v-btn icon slot="activator" :to="'/syllabus/' + assign.id">
                    <v-icon color="grey">visibility</v-icon>
                  </v-btn>
                  <span>View syllabus</span>
                </v-tooltip>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title v-text="'View syllabus'"/>
              </v-list-tile-content>
            </v-list-tile>

            <v-list-tile @click="() => {}">
              <v-list-tile-action class="thin-action">
                <v-tooltip top>
                  <v-btn icon slot="activator">
                    <v-icon color="grey">update</v-icon>
                  </v-btn>
                  <span>Last updated at</span>
                </v-tooltip>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>
                  {{ $wrap.datetime(assign.updated_at) }}
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

            <v-list-tile @click="() => {}">
              <v-list-tile-action class="thin-action">
                <v-tooltip top>
                  <v-btn icon slot="activator">
                    <v-icon color="grey">access_time</v-icon>
                  </v-btn>
                  <span>Created at</span>
                </v-tooltip>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>
                  {{ $wrap.datetime(assign.created_at) }}
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

            <v-list-tile @click="() => {}">
              <v-list-tile-action class="thin-action">
                <status :item="assign"/>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>Status:
                  <strong>{{ $wrap.status(assign.status) }}</strong>
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>

          </v-list>
        </v-flex>

        <v-flex xs12 sm6>

          <!-- end of about -->
          <div>

            <div class="body-1 grey--text">Assigned</div>
            <v-list>
              <v-list-tile @click="() => {}">
                <v-list-tile-action>
                  <icon-img
                    :item="assigned()"
                    color="primary"
                    size="32"
                    caption
                  />
                </v-list-tile-action>
                <v-list-tile-content
                  v-text="$wrap.fullname(assigned())"
                />
              </v-list-tile>
            </v-list>

            <template v-if="sub().length">
              <div class="body-1 grey--text">Reviewers</div>
              <v-list>
                <v-list-tile
                  :key="i"
                  v-for="(sub, i) in sub()"
                  @click="() => {}"
                >
                  <v-list-tile-action>
                    <icon-img
                      :item="sub.user"
                      color="primary"
                      size="32"
                      caption
                    />
                  </v-list-tile-action>
                  <v-list-tile-content
                    v-text="$wrap.fullname(sub.user)"
                  />
                  <v-list-tile-action>
                    <status :item="sub"/>
                  </v-list-tile-action>
                </v-list-tile>
              </v-list>

            </template>
          </div>

        </v-flex>

      </v-layout>

    </v-card-text>

    <v-card-actions>
      <v-spacer/>
      <v-btn
        flat
        color="primary"
        v-text="'Dismiss'"
        @click="show = false"
      />
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import Status from '@/include/Status'
import IconImg from '@/include/IconImg'

export default {
  name: 'dialog-detailed-workflow',
  components: {
    Status,
    IconImg
  },
  data: () => ({
    show: false,
    assign: null,
    loading: false
  }),
  watch: {
    show(e) {
      // if unshow
      if (!e) {
        this.clear()
      }
    }
  },

  created() {
    this.$bus.$on('dialog--detailed-workflow.show', (e) => {
      this.assign = e
      this.show = true
    })
  },

  methods: {
    clear() {
      this.assign = null
      this.show = false
    },

    course() {
      return this.assign.content.course
    },
    assigned() {
      return this.assign.content.assigned
    },
    sub() {
      return this.assign.content.sub
    }
  }
}
</script>
