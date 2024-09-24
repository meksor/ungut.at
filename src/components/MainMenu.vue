<template>
  <div class="main-menu">
    <div class="main-menu__items primary-bold">
      <!-- <nuxt-link to="#">
        CV
      </nuxt-link>
      <nuxt-link to="#info">
        Info
      </nuxt-link> -->
      <nuxt-link to="/works/">
        <h1>Works</h1>
      </nuxt-link>
    </div>
  </div>
</template>

<style lang="scss">
@import '@/assets/scss/variables.scss';

.main-menu {
  width: 100%;
  display: flex;  
  justify-content: center;
}

.main-menu__items {
  margin: map-get($spacing, 'lg') auto;
  display: flex;
  flex-direction: row;

  a {
    margin: 0 map-get($spacing, 'xl');
    text-decoration: none;
    color: map-get($shades, 'white');
  }

  a:hover {
    text-decoration: underline;
  }
}
</style>