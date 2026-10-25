#!/usr/bin/env python3
"""
Rustina V1 Fa - Python Integration Example
Run the model inside your Python apps using llama-cpp-python or subprocess.
Developer: Sina Khanzadeh (https://sina-khanzadeh.ir)
"""

import sys

def run_with_rust_llama(prompt):
    import subprocess
    cmd = [
        "./rust-llama", "run", "Rustina-V1-Fa-Q4_K_M.gguf",
        "-p", prompt, "--temp", "0.4", "-n", "128"
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    return res.stdout

def run_with_llama_cpp(prompt):
    try:
        from llama_cpp import Llama
        llm = Llama(model_path="Rustina-V1-Fa-Q4_K_M.gguf", n_ctx=2048, verbose=False)
        output = llm.create_chat_completion(
            messages=[
                {"role": "system", "content": "شما دستیار هوش مصنوعی رسمی راستینا (Rustina) هستید."},
                {"role": "user", "content": prompt}
            ],
            max_tokens=128,
            temperature=0.4
        )
        return output["choices"][0]["message"]["content"]
    except ImportError:
        return "Install llama-cpp-python with: pip install llama-cpp-python"

if __name__ == "__main__":
    prompt = sys.argv[1] if len(sys.argv) > 1 else "سلام! خودت را معرفی کن."
    print("User:", prompt)
    print("--- Output ---")
    print(run_with_rust_llama(prompt))
