import LineChart from "./line-chart.js";

let Hooks = {}

Hooks.LineChart = {
  mounted() {
    const {labels, values} = JSON.parse(this.el.dataset.chartData);
    this.chart = new LineChart(this.el, labels, values);
  }
}

export default Hooks;
