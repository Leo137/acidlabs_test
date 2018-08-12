# Santiago (CL), Zurich (CH), Auckland (NZ), Sydney (AU), Londres (UK), Georgia (USA)
cities = [
  { name: 'Santiago', country_code: 'CL', lattitude: -33.447487, longitude: -70.673676},
  { name: 'Zurich', country_code: 'CH', lattitude: 47.451542, longitude: 8.564572},
  { name: 'Auckland', country_code: 'NZ', lattitude: -36.848461, longitude: 174.763336},
  { name: 'Sydney', country_code: 'AU', lattitude: -33.865143, longitude: 151.209900},
  { name: 'Londres', country_code: 'UK', lattitude: 51.509865, longitude: -0.118092},
  { name: 'Georgia', country_code: 'USA', lattitude: 33.247875, longitude: -83.441162},
]

Rails.cache.write('cities', cities)