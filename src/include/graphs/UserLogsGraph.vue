<template>
<v-card>
  <v-card-title primary-title>
    <div>
      <h3 class="title mb-2">
        <span v-if="user" v-text="$wrap.fullname(user)"/>
        <span class="grey--text text--darken-1" v-html="title"/>
      </h3>
      <div
        class="caption grey--text"
      >
        <template>Showing logs from</template>
        <strong>{{ getStartDate() }}</strong>
        <template>to</template>
        <strong>{{ getEndDate() }}</strong>.
      </div>
    </div>
  </v-card-title>
  <v-card-text class="pt-1">
    <div
      v-if="loading && !logs"
      class="text-xs-center caption grey--text pa-2"
    >Loading...</div>
    <div class="full-width">
      <canvas
        ref="chart"
        :width="width"
        :height="height"
      ></canvas>
    </div>
  </v-card-text>
</v-card>
</template>

<script>
import qs from 'qs'
import Chart from 'chart.js'

export default {
  name: 'user-logs-graph',
  props: {
    id: [Number, String],
    logIn: {
      type: Boolean,
      default: false
    },
    logOut: {
      type: Boolean,
      default: false
    },
    title: {
      type: String,
      default: 'User Log Statistics'
    },
    width: {
      type: [Number, String],
      default: 360
    },
    height: {
      type: [Number, String],
      default: 128
    }
  },
  data: () => ({
    url: '/logs/user',
    chart: null,
    logs: [],
    user: null,
    graphDataIns: null,
    graphDataOuts: null,
    colors: {},
    loading: false
  }),

  watch: {
    id(e) {
      this.fetch()
    },
    logs: {
      deep: true,
      handler(e) {
        this.setChart()
      }
    }
  },

  mounted() {
    this.fetch()
  },

  methods: {
    getStartDate() {
      if (!this.graphDataIns) {
        return '?'
      }
      return Object.keys(this.graphDataIns)[0]
    },
    getEndDate() {
      if (!this.graphDataIns) {
        return '?'
      }
      let keys = Object.keys(this.graphDataIns)
      return keys[keys.length-1]
    },

    setChart() {
      if (!this.$refs.chart || this.graphDataIns === null || this.graphDataOuts === null) {
        return
      }
      // destroy current chart
      if (this.chart !== null) {
        this.chart.destroy()
      }

      let dates = Object.keys(this.graphDataIns)
      let logIns = Object.values(this.graphDataIns)

      // let datesOut = Object.keys(this.graphDataOuts)
      let logOuts = Object.values(this.graphDataOuts)

      const primaryColor = '#319e61'
      const warningColor = '#ff7043'

      let datasets = [
        {
          label: 'Ins',
          backgroundColor: primaryColor,
          borderColor: primaryColor,
          data: logIns,
          fill: false
        },
        {
          label: 'Outs',
          backgroundColor: warningColor,
          borderColor: warningColor,
          data: logOuts,
          fill: false
        },
      ]

      // create chart
      this.chart = new Chart(this.$refs.chart, {
        type: 'line',
        data: {
          labels: dates,
          datasets: datasets
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          // legend: {
          //   display: false
          // },
          tooltips: {
            mode: 'index',
            intersect: false
          },
          hover: {
            mode: 'nearest',
            intersect: true
          },
          scales: {
            xAxes: [{
              display: false
            }],
            yAxes: [{
              ticks: {
                suggestedMin: 0,
                suggestedMax: 4,
                beginAtZero: true
              }
            }]
          }
        }
      })

    },
    
    fetch() {
      this.loading = true
      let id =
        typeof this.id === 'undefined' || this.id === null
          ? null
          : this.id
      this.$http.post(this.url, qs.stringify({
        id: id,
        in: this.logIn,
        out: this.logOut,
        graph: true,
        monthly: true
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.user = res.data.user
        this.logs = res.data.logs
        this.graphDataIns = res.data.graphDataIns
        this.graphDataOuts = res.data.graphDataOuts
        // this.setChart()
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
