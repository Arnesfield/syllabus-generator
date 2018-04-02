<template>
<div>

  <div>
    <syllabus-inst
      ref="syllabusInst"
      :syllabus="syllabus"
      style="margin: 0 auto"
      standardHeight="calc(100vh - 260px)"
      pdfHeight="calc(100vh - 264px)"
      :pdf.sync="pdf"
    />
  </div>

  <v-container fluid class="pt-2">
    <v-layout row wrap>
      <v-btn
        large
        color="warning"
        @click="generate(!pdf)"
      >
        <template v-if="pdf">
          <v-icon>subject</v-icon>&nbsp;
          <span>Preview standard</span>
        </template>
        <template v-else>
          <v-icon>picture_as_pdf</v-icon>&nbsp;
          <span>Preview as PDF</span>
        </template>
      </v-btn>

      <v-btn
        large
        color="primary lighten-1"
        @click="$emit('submit')"
      >
        <v-icon>send</v-icon>&nbsp;
        <span>Submit for approval</span>
      </v-btn>

    </v-layout>
  </v-container>

</div>
</template>

<script>
import SyllabusInst from '@/include/SyllabusInst'

export default {
  name: 'syllabus-preview',
  components: {
    SyllabusInst
  },
  props: {
    syllabus: Object
  },
  data: () => ({
    pdf: false
  }),

  methods: {
    generate(e) {
      this.pdf = e
      if (this.$refs.syllabusInst) {
        this.$refs.syllabusInst.generate(e)
      }
    }
  }
}
</script>
