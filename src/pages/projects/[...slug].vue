<template>
  <div>
    <ContentDoc v-slot="{ doc }">
      <article class="body-bold">
        <h1>{{ doc.title }}</h1>
        <ContentRenderer :value="doc" />
      </article>
    </ContentDoc>  
  </div>
</template>
