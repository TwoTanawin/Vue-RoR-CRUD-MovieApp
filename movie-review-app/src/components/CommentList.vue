<template>
    <div class="p-4">
      <h1 class="text-2xl font-bold mb-4">Comments</h1>
      <button @click="showCreateModal = true" class="mb-4 px-4 py-2 bg-blue-500 text-white rounded">Add Comment</button>
  
      <!-- Create Modal -->
      <transition name="modal">
        <div class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center" v-if="showCreateModal">
          <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
            <h2 class="text-xl font-semibold mb-4">Create Comment</h2>
            <select v-model="newComment.movieId" class="mb-2 p-2 border rounded w-full">
              <option v-for="movie in movies" :key="movie.id" :value="movie.id">{{ movie.title }}</option>
            </select>
            <select v-model="newComment.reviewerId" class="mb-2 p-2 border rounded w-full">
              <option v-for="reviewer in reviewers" :key="reviewer.id" :value="reviewer.id">{{ reviewer.name }}</option>
            </select>
            <textarea v-model="newComment.content" placeholder="Content" class="mb-4 p-2 border rounded w-full"></textarea>
            <button @click="createComment" class="px-4 py-2 bg-green-500 text-white rounded">Save</button>
            <button @click="showCreateModal = false" class="px-4 py-2 bg-red-500 text-white rounded">Cancel</button>
          </div>
        </div>
      </transition>
  
      <ul>
        <li v-for="comment in comments" :key="comment.id" class="mb-2 p-4 border rounded">
          <h2 class="text-xl font-semibold">Movie: {{ comment.movie.title }}</h2>
          <h3 class="text-lg font-semibold">Reviewer: {{ comment.reviewer.name }}</h3>
          <p>{{ comment.content }}</p>
          <button @click="editComment(comment)" class="px-4 py-2 bg-yellow-500 text-white rounded">Edit</button>
          <button @click="deleteComment(comment.id)" class="px-4 py-2 bg-red-500 text-white rounded">Delete</button>
        </li>
      </ul>
  
      <!-- Edit Modal -->
      <transition name="modal">
        <div class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center" v-if="showEditModal">
          <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
            <h2 class="text-xl font-semibold mb-4">Edit Comment</h2>
            <select v-model="editCommentData.movieId" class="mb-2 p-2 border rounded w-full">
              <option v-for="movie in movies" :key="movie.id" :value="movie.id">{{ movie.title }}</option>
            </select>
            <select v-model="editCommentData.reviewerId" class="mb-2 p-2 border rounded w-full">
              <option v-for="reviewer in reviewers" :key="reviewer.id" :value="reviewer.id">{{ reviewer.name }}</option>
            </select>
            <textarea v-model="editCommentData.content" placeholder="Content" class="mb-4 p-2 border rounded w-full"></textarea>
            <button @click="updateComment" class="px-4 py-2 bg-green-500 text-white rounded">Update</button>
            <button @click="showEditModal = false" class="px-4 py-2 bg-red-500 text-white rounded">Cancel</button>
          </div>
        </div>
      </transition>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue';
  
  export default {
    setup() {
      const comments = ref([]);
      const movies = ref([]);
      const reviewers = ref([]);
      const showCreateModal = ref(false);
      const showEditModal = ref(false);
      const newComment = ref({ movieId: '', reviewerId: '', content: '' });
      const editCommentData = ref(null);
      let editingCommentId = ref(null);
  
      const fetchMovies = async () => {
        const response = await fetch('http://localhost:3000/movies');
        const data = await response.json();
        movies.value = data.movies;
      };
  
      const fetchReviewers = async () => {
        const response = await fetch('http://localhost:3000/reviewers');
        const data = await response.json();
        reviewers.value = data.reviewers;
      };
  
      const fetchComments = async () => {
        const response = await fetch('http://localhost:3000/comment2s');
        const data = await response.json();
        comments.value = data.comment2s;
      };
  
      onMounted(() => {
        fetchMovies();
        fetchReviewers();
        fetchComments();
      });
  
      const createComment = async () => {
        const response = await fetch('http://localhost:3000/comment2s', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ comment2: newComment.value }),
        });
        const data = await response.json();
        if (response.ok) {
          comments.value.push(data.comment2);
          newComment.value = { movieId: '', reviewerId: '', content: '' };
          showCreateModal.value = false;
        }
      };
  
      const editComment = (comment) => {
        editCommentData.value = { ...comment };
        editingCommentId.value = comment.id;
        showEditModal.value = true;
      };
  
      const updateComment = async () => {
        const response = await fetch(`http://localhost:3000/comment2s/${editingCommentId.value}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ comment2: editCommentData.value }),
        });
        const data = await response.json();
        if (response.ok) {
          const index = comments.value.findIndex(comment => comment.id === editingCommentId.value);
          comments.value[index] = data.comment2;
          showEditModal.value = false;
        }
      };
  
      const deleteComment = async (id) => {
        await fetch(`http://localhost:3000/comment2s/${id}`, {
          method: 'DELETE',
        });
        comments.value = comments.value.filter(comment => comment.id !== id);
      };
  
      return {
        comments,
        movies,
        reviewers,
        showCreateModal,
        showEditModal,
        newComment,
        editCommentData,
        createComment,
        editComment,
        updateComment,
        deleteComment,
      };
    },
  };
  </script>
  
  <style scoped>
  .modal-enter-active, .modal-leave-active {
    transition: opacity 0.5s;
  }
  .modal-enter, .modal-leave-to {
    opacity: 0;
  }
  </style>
  