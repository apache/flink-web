/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';

(function () {
  const indexCfg = {{ with i18n "bookSearchConfig" }}
    {{ . }};
  {{ else }}
   {};
  {{ end }}

  indexCfg.doc = {
    id: 'id',
    field: ['title', 'content'],
    store: ['title', 'href', 'section'],
  };

  const index = FlexSearch.create('balance', indexCfg);
  window.bookSearchIndex = index;

  {{- $pages := where .Site.Pages "Kind" "in" (slice "page" "section") -}}
  {{- $pages = where $pages "Params.booksearchexclude" "!=" true -}}

  {{ $.Scratch.Set "counter" 0 }}
  {{ range $page := $pages }}
    {{ if ne $page.Plain "" }}
      {{ if ne $page.Plain nil }}
        index.add({
          'id': {{$.Scratch.Get "counter"}},
          'href': '{{ $page.RelPermalink }}',
          'title': {{ (partial "docs/simple-title" $page) | jsonify }},
          'section': {{ (partial "docs/simple-title" $page.Parent) | jsonify }},
          'content': {{ $page.Plain | jsonify }}
        });
        {{ $.Scratch.Add "counter" 1 }}
      {{ end }}
    {{ end }}
  {{- end -}}
})();
