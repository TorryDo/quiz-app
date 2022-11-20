class Pair<K, V>{
  K key;
  V value;
  Pair(this.key, this.value);
}

Pair<K, V> pairOf<K, V>(K key, V value) => Pair(key, value);