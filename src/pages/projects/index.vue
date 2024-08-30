<template>
  <div>
    <ContentDoc path="/projects/" />
    <ContentList path="/projects" v-slot="{ list }">
      <div v-for="p in list" :key="p._path">
        <a :href="p._path"> <h2>{{ p.title }}</h2> </a>
        <p>{{ p.date }}</p>
      </div>
    </ContentList>
  </div>
</template>
