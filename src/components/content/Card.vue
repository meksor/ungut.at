<template>
  <div class="card shadow ba bw-4" :style="styles">
    <slot></slot>
    <div class="card__background" :style="bgStyles">
      <slot name="background"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
const img = useImage()

interface Props {
  color?: string
  borderColor?: string
  aspectRatio?: string
  bgImage?: string
}

const props = withDefaults(defineProps<Props>(), {
  color: 'surface',
  borderColor: 'black',
  aspectRatio: 'unset',
})

const styles = computed(() =>
{
  return {
    borderColor: `var(--color-${props.borderColor})`,
    aspectRatio: props.aspectRatio
  }
})
const bgStyles = computed(() =>
{
  const styles: any = {
    backgroundColor: `var(--color-${props.color})`,
  }
  if (props.bgImage){
    const imgUrl = img(props.bgImage);
    styles.backgroundImage = `url('${imgUrl}')`;
  }
  return styles;
})


</script>


<style lang="scss">
.card {
  position: relative;
  display: block;
  z-index: 0;
}
.card__background {
  position: absolute;
  overflow: hidden;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  background-size: cover;
  background-position: center center;
}
</style>
