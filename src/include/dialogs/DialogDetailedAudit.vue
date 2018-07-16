<template>
<v-dialog
  v-model="show"
  transition="fade-transition"
  width="420"
  scrollable
>
  <v-card v-if="show">

    <v-progress-linear
      color="warning"
      height="3"
      :active="loading"
      v-if="loading"
      indeterminate
      background-color="white"
      class="ma-0 white"
    />

    <v-card-text class="pl-0 pr-3 pt-2 pb-0">
      
      <v-layout row wrap align-center>
        <!-- user -->
        <v-layout row wrap align-center>
          <span class="ml-3">
            <icon-img
              :item="item"
              color="primary lighten-1"
              size="32"
              caption
            />
          </span>
          <v-subheader class="py-0 pl-1 ml-2">
            <div>
              <div>
                <span v-text="$wrap.fullname(item)"/>
                <add-me :id="item.user_id"/>
              </div>
              <div
                class="caption"
                v-if="item.title"
              >{{ item.title }}</div>
            </div>
          </v-subheader>
        </v-layout>

        <v-spacer/>

        <!-- time -->
        <div class="caption text-xs-right grey--text">
          <div v-html="$moment.unix(item.created_at).format('MMMM DD, YYYY')"></div>
          <div v-html="$moment.unix(item.created_at).format('h:mm A')"></div>
        </div>

      </v-layout>

      <div class="px-3 py-2">
        <div
          class="mb-2"
          v-html="$md.makeHtml(item.content)"
        />

        <!-- display item contents here -->

        <!-- related user -->
        <div
          v-if="item.related_user"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">User Info</div>
          <div>User ID: <strong v-text="item.related_user_id"/></div>
          <div>{{ $wrap.fullname(item.related_user) }}</div>
          <div>{{ item.related_user.title }}</div>
        </div>

        <!-- course -->
        <div
          v-if="item.course"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">Course Info</div>
          <div>Course ID: <strong v-text="item.course_id"/></div>
          <div>{{ item.course.code }}</div>
          <div>{{ item.course.title }}</div>
        </div>

        <!-- assign -->
        <div
          v-if="item.assign"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">Workflow Info</div>
          <!-- <a
            @click="$router.push('/syllabus/' + item.assign_id)"
            style="text-decoration: underline"
          >View workflow syllabus</a> -->
          <div>Workflow ID: <strong v-text="item.assign_id"/></div>
          <div class="primary--text mt-2">Course Info</div>
          <div>Course ID: <strong v-text="item.assign.content.course.id"/></div>
          <div>{{ item.assign.content.course.code }}</div>
          <div>{{ item.assign.content.course.title }}</div>
        </div>

        <!-- curriculum -->
        <div
          v-if="item.curriculum"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">Curriculum Info</div>
          <div>Curriculum ID: <strong v-text="item.curriculum_id"/></div>
          <div>{{ item.curriculum.label }}</div>
        </div>

        <!-- outcome -->
        <div
          v-if="item.outcome"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">Outcome Info</div>
          <div>Outcome ID: <strong v-text="item.outcome_id"/></div>
          <div v-html="$md.makeHtml(item.outcome.content)"/>
        </div>

        <!-- syllabus -->
        <div
          v-if="item.syllabus"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">Syllabus Info</div>
          <div>Syllabus ID: <strong v-text="item.syllabus_id"/></div>
          <!-- <a
            @click="$router.push('/syllabus/view/' + item.course_id + '/' + item.syllabus_id)"
            style="text-decoration: underline"
          >View syllabus</a> -->
        </div>

        <!-- book -->
        <div
          v-if="item.book"
          class="ml-2 caption grey--text text--darken-1"
        >
          <div class="primary--text">Book Info</div>
          <div>Book ID: <strong v-text="item.book_id"/></div>
          <div v-html="$md.makeHtml(item.book.citation)"/>
        </div>

      </div>

    </v-card-text>
      
    <v-card-actions>
      <v-spacer/>
      <v-btn
        flat
        color="primary lighten-1"
        tabindex="0"
        @click="show = false"
        @keypress.enter="show = false"
        v-text="'Dismiss'"
      />
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'
import AddMe from '@/include/AddMe'
import IconImg from '@/include/IconImg'

export default {
  name: 'dialog-detailed-audit',
  components: {
    AddMe,
    IconImg
  },
  data: () => ({
    url: '/logs/detailed',
    item: null,
    show: false,
    loading: false
  }),

  watch: {
    show(e) {
      if (!e) {
        this.item = null
      }
    }
  },
  
  methods: {
    viewItem(item) {
      this.item = item
      this.show = true
      this.fetch()
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        item: this.item
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.item = res.data.item
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
