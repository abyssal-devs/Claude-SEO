# Skills disponíveis no Claude Code

> Última atualização: 2026-05-26 | Versão do pacote SEO: 1.0

Todas as skills abaixo estão instaladas em `~/.claude/skills/` e ficam disponíveis automaticamente no Claude Code como comandos `/nome-da-skill`.

---

## Skills SEO

| Skill | Versão | Argumento | Descrição |
|-------|--------|-----------|-----------|
| `/seo` | 1.9.9 | `[command] [url]` | Análise SEO completa para qualquer tipo de site. Auditorias, SEO técnico, schema, E-E-A-T, imagens, sitemaps e GEO para AI Overviews. Orquestra 24 sub-skills. |
| `/seo-audit` | 1.9.9 | `[url]` | Auditoria completa do site com delegação paralela a sub-agentes. Rastreia até 500 páginas e detecta tipo de negócio. |
| `/seo-backlinks` | 1.9.9 | `<url>` | Análise de perfil de backlinks: domínios referenciadores, distribuição de anchor text, links tóxicos, gap de competidores. |
| `/seo-cluster` | 1.9.9 | `<seed-keyword or url>` | Clustering semântico de tópicos baseado em SERP real. Cria clusters hub-and-spoke com matrizes de links internos e visualizações. |
| `/seo-competitor-pages` | 1.9.9 | `[url or generate] [competitor]` | Gera páginas de comparação e alternativas otimizadas para SEO no estilo "X vs Y" e "alternativas ao X". |
| `/seo-content` | 1.9.9 | `[url]` | Análise de qualidade de conteúdo e E-E-A-T com avaliação de prontidão para citações por IA. |
| `/seo-content-brief` | 1.0.0 | `[url-or-keyword] [page-type]` | Gera briefs de conteúdo competitivos com contagens de palavras por seção, scoring de competidores e orientação de densidade de keywords. |
| `/seo-dataforseo` | 1.9.9 | `[command] [query]` | Dados SEO em tempo real via DataForSEO MCP: análise de SERP (Google, Bing, Yahoo, YouTube), pesquisa de keywords, análise de competidores. |
| `/seo-drift` | 1.9.9 | `baseline\|compare\|history <url>` | Monitoramento de drift SEO: captura baselines de elementos críticos, detecta mudanças e rastreia regressões ao longo do tempo. |
| `/seo-ecommerce` | 1.9.9 | `<url or keyword>` | SEO para e-commerce: visibilidade no Google Shopping, inteligência Amazon, validação de schema de produto, análise de competidores. |
| `/seo-firecrawl` | 1.9.9 | `[command] <url>` | Rastreamento completo do site, scraping e mapeamento via Firecrawl MCP. |
| `/seo-flow` | 1.9.9 | `[stage] [url\|topic]` | Integração do framework FLOW — SEO baseado em evidências usando o loop Find → Leverage → Optimize → Win. |
| `/seo-geo` | 1.9.9 | `[url]` | Otimização para AI Overviews (SGE), ChatGPT Search, Perplexity e outras experiências de busca com IA. Inclui GEO, llms.txt e citabilidade. |
| `/seo-google` | 1.9.9 | `[command] [url\|property]` | APIs Google SEO: Search Console (Search Analytics, URL Inspection, Sitemaps), PageSpeed Insights v5, CrUX. |
| `/seo-hreflang` | 1.9.9 | `[url]` | Auditoria, validação e geração de hreflang para SEO internacional. Detecta erros comuns de idioma/região. |
| `/seo-image-gen` | 1.9.9 | `[og\|hero\|product\|infographic\|custom\|batch] <desc>` | Geração de imagens por IA para SEO: imagens OG/social, hero de blog, imagens de schema, fotografia de produto, infográficos. |
| `/seo-images` | 1.9.9 | `[url]` | Análise de otimização de imagens para SEO e performance: alt text, tamanhos, formatos, imagens responsivas, lazy loading. |
| `/seo-local` | 1.9.9 | `[url]` | SEO local: otimização do Google Business Profile, consistência de NAP, citations, sinais de reviews, schema local, páginas de localização. |
| `/seo-maps` | 1.9.9 | `[command] [url\|keyword\|location]` | Inteligência de mapas para SEO local: rastreamento de rank em geo-grid, auditoria de GBP, inteligência de reviews no Google Maps e Apple Maps. |
| `/seo-page` | 1.9.9 | `[url]` | Análise profunda de página única: elementos on-page, qualidade de conteúdo, meta tags técnicas, schema, imagens e performance. |
| `/seo-plan` | 1.9.9 | `[business-type]` | Planejamento estratégico de SEO para sites novos ou existentes. Templates por setor, análise competitiva, estratégia de conteúdo. |
| `/seo-programmatic` | 1.9.9 | `[url or plan]` | Planejamento e análise de SEO programático para páginas geradas em escala a partir de fontes de dados. |
| `/seo-schema` | 1.9.9 | `[url]` | Detecta, valida e gera dados estruturados Schema.org. Formato JSON-LD preferido. |
| `/seo-sitemap` | 1.9.9 | `[url or generate]` | Analisa sitemaps XML existentes ou gera novos com templates por setor. Valida formato, URLs e estrutura. |
| `/seo-sxo` | 1.9.9 | `<url> [keyword]` | Search Experience Optimization: lê SERPs do Google de trás para frente para detectar incompatibilidades de tipo de página. |
| `/seo-technical` | 1.9.9 | `[url]` | Auditoria técnica de SEO em 9 categorias: rastreabilidade, indexabilidade, segurança, estrutura de URL, mobile, Core Web Vitals, schema. |

---

## Como usar as skills no Claude Code

```bash
# Exemplos de uso no terminal com Claude Code
claude /seo audit https://seusite.com
claude /seo-page https://seusite.com/pagina
claude /seo-local https://seusite.com
claude /seo-geo https://seusite.com
claude /seo-technical https://seusite.com
```

Ou simplesmente inicie uma conversa no Claude Code e invoque a skill pelo nome:

```
/seo audit https://seusite.com
/seo-cluster "marketing digital"
/seo-content-brief "como fazer SEO" landing-page
```

---

## Estrutura de pastas

```
~/.claude/skills/
├── CLAUDE.md              ← este arquivo
├── seo/                   ← skill principal (orquestra todas)
├── seo-audit/
├── seo-backlinks/
├── seo-cluster/
├── seo-competitor-pages/
├── seo-content/
├── seo-content-brief/
├── seo-dataforseo/
├── seo-drift/
├── seo-ecommerce/
├── seo-firecrawl/
├── seo-flow/
├── seo-geo/
├── seo-google/
├── seo-hreflang/
├── seo-image-gen/
├── seo-images/
├── seo-local/
├── seo-maps/
├── seo-page/
├── seo-plan/
├── seo-programmatic/
├── seo-schema/
├── seo-sitemap/
├── seo-sxo/
└── seo-technical/
```

---

## Notas

- A skill `/seo` é o ponto de entrada principal e orquestra as demais automaticamente conforme o comando.
- As skills `seo-dataforseo`, `seo-google`, `seo-firecrawl` e `seo-maps` requerem MCPs/APIs configurados separadamente.
- A skill `seo-image-gen` requer um modelo de geração de imagens disponível.
- Para instalar ou atualizar skills, use o Cowork mode com o skill-creator.
