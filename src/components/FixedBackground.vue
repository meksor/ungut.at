<template>
  <div id="foreground">
    <slot/>
  </div>

  <div id="background">
    <slot name="background" />
  </div>
</template>

<style lang="scss">

#foreground {
  z-index: 20;
  position: relative;
  min-width: 100vw;
  min-height: calc(100% + 0px);
}
#background {
  position: fixed;
  top: 0;
  left: 0;  
  width: 100vw !important;
  height: 100vh !important;
}
#background > * {
  width: 100vw !important;
  height: 100vh !important;
}
</style>