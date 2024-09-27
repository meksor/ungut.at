<template>
  <div class="youtube-video">
    <iframe
      class="shadow hoverable"
      :src="`https://www.youtube-nocookie.com/embed/${props.videoId}`"
      title="YouTube video player"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
      referrerpolicy="strict-origin-when-cross-origin"
      allowfullscreen
    ></iframe>
  </div>
</template>

<script setup lang="ts">
interface Props {
  videoId: string;
}
const props = withDefaults(defineProps<Props>(), {
})

</script>

<style lang="scss">

.youtube-video iframe {
  max-width: 100%;
  width: 500px;
  height: 320px;
  margin-left: auto;
}
</style>