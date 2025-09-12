from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline, BitsAndBytesConfig
from langchain_huggingface import HuggingFacePipeline
from weather import get_weather
import torch


def load_model():
    model_name = "mistralai/Mistral-7B-Instruct-v0.2"

    torch.backends.cuda.matmul.allow_tf32 = True  # speed-up

    quant_config = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_use_double_quant=True,
        bnb_4bit_quant_type="nf4",
        bnb_4bit_compute_dtype="float16"
    )

    tokenizer = AutoTokenizer.from_pretrained(model_name)

    # Explicit device map + CPU offload
    max_memory = {
        0: "5GiB",    # GPU VRAM limit (RTX 3050 ~6GB, keep headroom)
        "cpu": "12GiB"  # CPU RAM fallback
    }

    model = AutoModelForCausalLM.from_pretrained(
        model_name,
        quantization_config=quant_config,
        device_map="auto",
        max_memory=max_memory,
        low_cpu_mem_usage=True,
        trust_remote_code=True
    )

    pipe = pipeline(
        "text-generation",
        model=model,
        tokenizer=tokenizer,
        max_new_tokens=200,
        temperature=0.7,
        top_p=0.9
    )

    llm = HuggingFacePipeline(pipeline=pipe)
    return llm


def chat_with_farmer(query, city=None, llm=None):
    if llm is None:
        llm = load_model()

    context = "Weather data unavailable."
    if city:
        weather = get_weather(city)
        if "error" not in weather:
            context = (
                f"Weather in {city}: {weather['temperature']}°C, "
                f"Humidity {weather['humidity']}%, "
                f"Condition {weather['condition']}."
            )

    final_query = (
        f"You are an expert farming assistant.\n"
        f"{context}\n"
        f"Farmer's Question: {query}\n"
        f"Answer in a short, clear, practical way for the farmer."
    )

    print("Assistant: ", end='', flush=True)
    for token in llm.stream(final_query):
           print(token, end='', flush=True)
    print() 


