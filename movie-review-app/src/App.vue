<template>
  <div id="app" class="container mx-auto">
    <nav class="bg-purple-800 p-4 mb-4">
      <ul class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-4">
        <li>
          <router-link to="/movies" class="text-white hover:text-purple-300">Movies</router-link>
        </li>
        <li>
          <router-link to="/reviewers" class="text-white hover:text-purple-300">Reviewers</router-link>
        </li>
        <li>
          <router-link to="/comments" class="text-white hover:text-purple-300">Comments</router-link>
        </li>
      </ul>
    </nav>
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',
};
</script>

<style>
/* Global styles */
body {
  font-family: Arial, sans-serif;
}
</style>
