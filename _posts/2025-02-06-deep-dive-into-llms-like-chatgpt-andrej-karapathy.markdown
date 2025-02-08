---
layout: post
title:  "Deep dive into LLMs like ChatGPT (Andrej Karpathy)"
date:   2025-02-06 21:40:39 -0700
categories: ai
---

Andrej Karpathy made a 3.5 hour long video about how LLMs like ChatGPT work. It's a great video for understanding the inner workings of LLMs.

It has a treasure trove of information, but it's a very long video, so I wanted to summarize the key points here so that I don't have to watch the whole thing again.

###Section 1: Training Data

LLMs are trained on a large corpus of text data. This is usually proprietary and not released to the public. But there are some open source corpora available.

He recommends [FineWeb](https://huggingface.co/datasets/HuggingFaceFW/fineweb) as a good source for training data freely available. 
It's built out of [Common Crawl](https://commoncrawl.org/) data that is cleaned and preprocessed. Read this 
[article](https://huggingface.co/spaces/HuggingFaceFW/blogpost-fineweb-v1) about what went into building this dataset.

_Some stats:_

**Raw Data:** 2.7 billion web pages, totaling 386 TiB of uncompressed HTML text content 

**Preprocessed Data:** 15-trillion tokens, 44TB disk space

### Section 2: Tokenization

Next, you take the raw text data and tokenize it. He used this [website](https://tiktokenizer.vercel.app/) ([mirror](https://tiktokenizer.f2api.com/))
to demonstrate how tokenization works.

Basically, you take the text and break it into tokens. Each token is assigned a unique integer id. Tokens are not characters, nor words, but are like
chunk of characters, that often show up in text. 


### Section 3: Training

Then he spoke about how LLMs are trained using a neural network, mainly a transformer model that is visualized [here](https://bbycroft.net/llm). Basically,
it's a token predictor. It is trained to take a sequence of tokens and predict the next token. In a way, it could be said that it's a document completor.

Given that it's a very large neural network which can have billions of parameters, and given that the training data is so huge, that training this entire
model required a lot of compute. Since this work can be parallelized, we use GPUs to train the model. 

He also covered the advancement of technology over the last few years, that had brought down the cost of training these models. For example, training GPT-2
is estimated to have cost around $40K, but today he could [train a similar model with $672](https://github.com/karpathy/llm.c/discussions/677), and that too
without trying to optimize the cost. And believes that this cost could be brought down to $100. Which is around 400x cheaper than what it used to be in 2019.

He credits this efficiency boost to the advancement in hardware, developer tools, and algorithm/computational optimizations.

Here is the GPT-2 Research Paper from OpenAI: [Language Models are Unsupervised Multitask Learners](https://cdn.openai.com/better-language-models/language_models_are_unsupervised_multitask_learners.pdf)

After training, you get a Base Model. Base model is a document completor. It's very powerful, but it's just a very expensive auto-completer. To turn this into
an AI assistant, you need post-training, which is covered in the next section.

Building the base model is very expensive, but once you have it, post-training is relatively cheap. So, it is a good idea to use a existing base model, and then
post-train it for a specific use-case.

There are several open source base models. He used [Llama 3.1 405B BF16](https://huggingface.co/meta-llama/Llama-3.1-405B) ([Meta's Llama 3.1 Announcement](https://ai.meta.com/blog/meta-llama-3-1/), 
[Meta's Llama 3 Paper](https://arxiv.org/abs/2407.21783)) as the base model for this tutorial. And he used [Hyperbolic](https://www.hyperbolic.xyz/blog/llama-3-1-405b-base-bf16) 
to demo the base model and it's capabilities.

### Section 4: Document Completors to AI Assistants

Now taking the base model, and building it into an AI assistant takes post-training. Post-training requires a dataset of input/output pairs, that tells the model
what could it expect as an input, and how should it respond.

This is the phase where you can give a certain personality to the model, and you can train the model to act a certain way.

Then he showed us a technique through which we can train the model to always respond in a certain way, with delimiters such as `<|im_start|>`, `<|im_end|>`, `<|im_sep|>` etc,
which the model has not seen during training phase, and is added during post-traning phase to tell the model how to respond.

This is from OpenAI's Instruct GPT paper [Training language models to follow instructions with human feedback](https://arxiv.org/pdf/2203.02155).

-- WORK IN PROGRESS --
