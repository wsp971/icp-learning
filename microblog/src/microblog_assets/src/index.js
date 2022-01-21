import { microblog } from "../../declarations/microblog";
import Vue from 'vue';
import app from './app.vue';
new Vue({
  render: h => h(app)
}).$mount('#app');

window.VUE_APP = app;

