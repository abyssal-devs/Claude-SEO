# Claude Code SEO Skills

Coleção de **skills** e **subagents** para [Claude Code](https://claude.com/claude-code) focados em SEO, GEO (AI search), conteúdo e SEO local/técnico.

- **28 skills** em [`skills/`](skills/)
- **18 subagents** em [`agents/`](agents/)
- Licença: **MIT**
- Autoria: predominantemente **Igor Quira** (exceção: `seo-programmatic` por *AgriciDaniel*; `blog-seo-copywriter` sem autor declarado)

## Instalação

Copie as pastas para o seu diretório do Claude Code (`~/.claude`):

```bash
cp -r skills/* ~/.claude/skills/
cp -r agents/* ~/.claude/agents/
```

As skills são acionadas via `/<nome-da-skill>` ou automaticamente pelos gatilhos descritos em cada `SKILL.md`.

## Skills

### Criação de conteúdo
| Skill | Funcionalidade | Inputs principais |
|---|---|---|
| `blog-seo-copywriter` | Posts de blog longos (1500–2000 palavras) otimizados para SEO em PT | URL de referência + tema (+ briefing opcional) |
| `seo-content-brief` | Briefings competitivos com word count por seção e densidade de keyword | URL/tema, keyword, tipo de página |
| `seo-competitor-pages` | Páginas "X vs Y", "alternativas a X", matrizes de features | Concorrentes/produtos a comparar |
| `seo-cluster` | Clustering semântico por sobreposição de SERP (hub-and-spoke) | Keywords-semente |
| `seo-plan` | Planejamento estratégico de SEO e roadmap | Site/domínio, indústria, objetivos |
| `seo-programmatic` | Planejamento de SEO programático (páginas em escala) | Fonte de dados, padrão de URL/template |

### Auditoria e análise
| Skill | Funcionalidade | Inputs principais |
|---|---|---|
| `seo` | SEO abrangente (site, página, técnico, schema, conteúdo, GEO) | URL/domínio |
| `seo-audit` | Auditoria completa com subagents paralelos e health score | URL/domínio |
| `seo-page` | Análise SEO profunda de página única | Uma URL |
| `seo-technical` | SEO técnico em 9 categorias | URL/domínio |
| `seo-content` | Qualidade de conteúdo, E-E-A-T, prontidão para IA | URL/conteúdo |
| `seo-drift` | Monitoramento de regressões de SEO (baseline + diff) | URL + baseline |
| `seo-sxo` | Search Experience Optimization, scoring por persona | URL + keyword |

### Técnico / estrutura
| Skill | Funcionalidade | Inputs principais |
|---|---|---|
| `seo-schema` | Detecta, valida e gera Schema.org (JSON-LD) | URL ou tipo de entidade |
| `seo-sitemap` | Analisa/gera sitemaps XML | URL do sitemap ou lista de páginas |
| `seo-hreflang` | Auditoria e geração de hreflang / SEO internacional | URLs multilíngues, idiomas/regiões |
| `seo-images` | Otimização de imagens (alt, WebP/AVIF, CLS, metadados) | URL/página com imagens |

### Local / Maps
| Skill | Funcionalidade | Inputs principais |
|---|---|---|
| `seo-local` | SEO local: GBP, NAP, citações, reviews, multi-location | Negócio/URL, localização |
| `seo-maps` | Geo-grid rank tracking, auditoria GBP, reviews | Nome do negócio, localização, raio |

### Dados externos (APIs / MCP)
| Skill | Funcionalidade | Inputs principais |
|---|---|---|
| `seo-backlinks` | Perfil de backlinks, anchors, links tóxicos, gap | Domínio (+ concorrentes) |
| `seo-dataforseo` | Dados ao vivo via DataForSEO (SERP, volume, backlinks) | Keyword/domínio/URL (requer extensão) |
| `seo-google` | Search Console, PageSpeed, CrUX, Indexing API, GA4 | Propriedade/URL + credenciais Google |
| `seo-firecrawl` | Crawl/scrape e mapeamento de site via Firecrawl MCP | URL (requer Firecrawl MCP) |
| `seo-ecommerce` | SEO e-commerce: Google Shopping, Amazon, schema de produto | URL de produto/loja |

### GEO / IA e frameworks
| Skill | Funcionalidade | Inputs principais |
|---|---|---|
| `seo-geo` | Otimização para AI Overviews/ChatGPT/Perplexity | URL/conteúdo |
| `seo-flow` | Framework FLOW (Find→Leverage→Optimize→Win), 41 prompts | URL/estágio FLOW |
| `seo-image-gen` | Geração de imagens SEO (OG, hero, infográfico) via Gemini | Prompt/página (requer extensão "banana") |

## Subagents (`agents/`)

`seo-backlinks`, `seo-cluster`, `seo-content`, `seo-dataforseo`, `seo-drift`,
`seo-ecommerce`, `seo-flow`, `seo-geo`, `seo-google`, `seo-image-gen`,
`seo-local`, `seo-maps`, `seo-performance`, `seo-schema`, `seo-sitemap`,
`seo-sxo`, `seo-technical`, `seo-visual`.

## Licença

[MIT](LICENSE) © 2026 Igor Quira
