import LineChart from "./line-chart.js";

let Hooks = {}

Hooks.LineChart = {
  mounted() {
    this.chart = new LineChart(this.el, [], []);
  }
}

export default Hooks;
