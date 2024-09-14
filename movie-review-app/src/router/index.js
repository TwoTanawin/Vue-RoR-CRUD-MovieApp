import { createRouter, createWebHistory } from 'vue-router';
import MovieList from '../components/MovieList.vue';
import ReviewerList from '../components/ReviewerList.vue';
import CommentList from '../components/CommentList.vue';

const routes = [
  { path: '/', redirect: '/movies' },
  { path: '/movies', component: MovieList },
  { path: '/reviewers', component: ReviewerList },
  { path: '/comments', component: CommentList },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
