import { microblog } from "../../declarations/microblog";
import Vue from 'vue';
import app from './app.vue';
import Toast from './components/toast.js';

Toast.install(Vue);
import "weui";
window.VUE_APP = new Vue({
  render: h => h(app)
}).$mount('#app');



