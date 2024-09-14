<template>
    <div class="p-4">
      <h1 class="text-2xl font-bold mb-4">Reviewers</h1>
      <button @click="showCreateModal = true" class="mb-4 px-4 py-2 bg-blue-500 text-white rounded">Add Reviewer</button>
  
      <!-- Create Modal -->
      <transition name="modal">
        <div class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center" v-if="showCreateModal">
          <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
            <h2 class="text-xl font-semibold mb-4">Create Reviewer</h2>
            <input v-model="newReviewer.name" type="text" placeholder="Name" class="mb-2 p-2 border rounded w-full" />
            <input v-model="newReviewer.email" type="email" placeholder="Email" class="mb-4 p-2 border rounded w-full" />
            <button @click="createReviewer" class="px-4 py-2 bg-green-500 text-white rounded">Save</button>
            <button @click="showCreateModal = false" class="px-4 py-2 bg-red-500 text-white rounded">Cancel</button>
          </div>
        </div>
      </transition>
  
      <ul>
        <li v-for="reviewer in reviewers" :key="reviewer.id" class="mb-2 p-4 border rounded">
          <h2 class="text-xl font-semibold">{{ reviewer.name }}</h2>
          <p>{{ reviewer.email }}</p>
          <button @click="editReviewer(reviewer)" class="px-4 py-2 bg-yellow-500 text-white rounded">Edit</button>
          <button @click="deleteReviewer(reviewer.id)" class="px-4 py-2 bg-red-500 text-white rounded">Delete</button>
        </li>
      </ul>
  
      <!-- Edit Modal -->
      <transition name="modal">
        <div class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center" v-if="showEditModal">
          <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
            <h2 class="text-xl font-semibold mb-4">Edit Reviewer</h2>
            <input v-model="editReviewerData.name" type="text" placeholder="Name" class="mb-2 p-2 border rounded w-full" />
            <input v-model="editReviewerData.email" type="email" placeholder="Email" class="mb-4 p-2 border rounded w-full" />
            <button @click="updateReviewer" class="px-4 py-2 bg-green-500 text-white rounded">Update</button>
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
      const reviewers = ref([]);
      const showCreateModal = ref(false);
      const showEditModal = ref(false);
      const newReviewer = ref({ name: '', email: '' });
      const editReviewerData = ref(null);
      let editingReviewerId = ref(null);
  
      const fetchReviewers = async () => {
        const response = await fetch('http://localhost:3000/reviewers');
        const data = await response.json();
        reviewers.value = data.reviewers;
      };
  
      onMounted(() => {
        fetchReviewers();
      });
  
      const createReviewer = async () => {
        const response = await fetch('http://localhost:3000/reviewers', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ reviewer: newReviewer.value }),
        });
        const data = await response.json();
        if (response.ok) {
          reviewers.value.push(data.reviewer);
          newReviewer.value = { name: '', email: '' };
          showCreateModal.value = false;
        }
      };
  
      const editReviewer = (reviewer) => {
        editReviewerData.value = { ...reviewer };
        editingReviewerId.value = reviewer.id;
        showEditModal.value = true;
      };
  
      const updateReviewer = async () => {
        const response = await fetch(`http://localhost:3000/reviewers/${editingReviewerId.value}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ reviewer: editReviewerData.value }),
        });
        const data = await response.json();
        if (response.ok) {
          const index = reviewers.value.findIndex(reviewer => reviewer.id === editingReviewerId.value);
          reviewers.value[index] = data.reviewer;
          showEditModal.value = false;
        }
      };
  
      const deleteReviewer = async (id) => {
        await fetch(`http://localhost:3000/reviewers/${id}`, {
          method: 'DELETE',
        });
        reviewers.value = reviewers.value.filter(reviewer => reviewer.id !== id);
      };
  
      return {
        reviewers,
        showCreateModal,
        showEditModal,
        newReviewer,
        editReviewerData,
        createReviewer,
        editReviewer,
        updateReviewer,
        deleteReviewer,
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
  