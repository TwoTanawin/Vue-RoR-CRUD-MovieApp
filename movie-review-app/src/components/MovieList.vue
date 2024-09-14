<template>
    <div class="p-4">
      <h1 class="text-2xl font-bold mb-4 text-purple-700">Movies</h1>
      <button @click="showCreateModal = true" class="mb-4 px-4 py-2 bg-purple-500 text-white rounded hover:bg-purple-600">Add Movie</button>
  
      <!-- Create Modal -->
      <transition name="modal">
        <div class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center" v-if="showCreateModal">
          <div class="bg-white p-6 rounded-lg shadow-lg w-11/12 sm:w-1/2 md:w-1/3">
            <h2 class="text-xl font-semibold mb-4 text-purple-700">Create Movie</h2>
            <input v-model="newMovie.title" type="text" placeholder="Title" class="mb-2 p-2 border rounded w-full border-purple-300" />
            <textarea v-model="newMovie.description" placeholder="Description" class="mb-4 p-2 border rounded w-full border-purple-300"></textarea>
            <button @click="createMovie" class="px-4 py-2 bg-purple-500 text-white rounded hover:bg-purple-600">Save</button>
            <button @click="showCreateModal = false" class="px-4 py-2 bg-purple-700 text-white rounded hover:bg-purple-800">Cancel</button>
          </div>
        </div>
      </transition>
  
      <ul>
        <li v-for="movie in movies" :key="movie.id" class="mb-2 p-4 border rounded border-purple-300">
          <h2 class="text-xl font-semibold text-purple-700">{{ movie.title }}</h2>
          <p>{{ movie.description }}</p>
          <button @click="editMovie(movie)" class="px-4 py-2 bg-purple-500 text-white rounded hover:bg-purple-600">Edit</button>
          <button @click="deleteMovie(movie.id)" class="px-4 py-2 bg-purple-700 text-white rounded hover:bg-purple-800">Delete</button>
        </li>
      </ul>
  
      <!-- Edit Modal -->
      <transition name="modal">
        <div class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center" v-if="showEditModal">
          <div class="bg-white p-6 rounded-lg shadow-lg w-11/12 sm:w-1/2 md:w-1/3">
            <h2 class="text-xl font-semibold mb-4 text-purple-700">Edit Movie</h2>
            <input v-model="editMovieData.title" type="text" placeholder="Title" class="mb-2 p-2 border rounded w-full border-purple-300" />
            <textarea v-model="editMovieData.description" placeholder="Description" class="mb-4 p-2 border rounded w-full border-purple-300"></textarea>
            <button @click="updateMovie" class="px-4 py-2 bg-purple-500 text-white rounded hover:bg-purple-600">Update</button>
            <button @click="showEditModal = false" class="px-4 py-2 bg-purple-700 text-white rounded hover:bg-purple-800">Cancel</button>
          </div>
        </div>
      </transition>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue';
  
  export default {
    setup() {
      const movies = ref([]);
      const showCreateModal = ref(false);
      const showEditModal = ref(false);
      const newMovie = ref({ title: '', description: '' });
      const editMovieData = ref(null);
      let editingMovieId = ref(null);
  
      const fetchMovies = async () => {
        const response = await fetch('http://localhost:3000/movies');
        const data = await response.json();
        movies.value = data.movies;
      };
  
      onMounted(() => {
        fetchMovies();
      });
  
      const createMovie = async () => {
        const response = await fetch('http://localhost:3000/movies', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ movie: newMovie.value }),
        });
        const data = await response.json();
        if (response.ok) {
          movies.value.push(data.movie);
          newMovie.value = { title: '', description: '' };
          showCreateModal.value = false;
        }
      };
  
      const editMovie = (movie) => {
        editMovieData.value = { ...movie };
        editingMovieId.value = movie.id;
        showEditModal.value = true;
      };
  
      const updateMovie = async () => {
        const response = await fetch(`http://localhost:3000/movies/${editingMovieId.value}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ movie: editMovieData.value }),
        });
        const data = await response.json();
        if (response.ok) {
          const index = movies.value.findIndex(movie => movie.id === editingMovieId.value);
          movies.value[index] = data.movie;
          showEditModal.value = false;
        }
      };
  
      const deleteMovie = async (id) => {
        await fetch(`http://localhost:3000/movies/${id}`, {
          method: 'DELETE',
        });
        movies.value = movies.value.filter(movie => movie.id !== id);
      };
  
      return {
        movies,
        showCreateModal,
        showEditModal,
        newMovie,
        editMovieData,
        createMovie,
        editMovie,
        updateMovie,
        deleteMovie,
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
  