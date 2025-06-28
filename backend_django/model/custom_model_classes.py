# === ISI FILE custom_model_classes.py ===

# Impor semua pustaka yang dibutuhkan oleh kelas-kelas Anda
import torch
import torch.nn as nn
from transformers import AutoTokenizer, AutoModel
import pandas as pd
import re
from Sastrawi.Stemmer.StemmerFactory import StemmerFactory
from Sastrawi.StopWordRemover.StopWordRemoverFactory import StopWordRemoverFactory
import warnings
from sklearn.preprocessing import LabelEncoder

warnings.filterwarnings('ignore')

# --- KELAS 1: IndonesianTextPreprocessor ---
class IndonesianTextPreprocessor:
    def __init__(self):
        self.stemmer = StemmerFactory().create_stemmer()
        self.stopword_remover = StopWordRemoverFactory().create_stop_word_remover()
        
        try:
            alay_path = './indonesian-abusive-and-hate-speech-twitter-text/new_kamusalay.csv'
            alay = pd.read_csv(alay_path, encoding='latin-1', header=None)
            alay_dict = dict(zip(alay[0], alay[1]))
            self.slang_dict = {
                'gk': 'tidak', 'gak': 'tidak', 'ga': 'tidak', 'bgt': 'banget',
                'lg': 'lagi', 'dah': 'sudah', 'sih': '', 'nih': 'ini',
                'tuh': 'itu', 'yg': 'yang', 'dgn': 'dengan', 'krn': 'karena',
                'tp': 'tetapi', 'klo': 'kalau', 'gmn': 'bagaimana', 'dmn': 'dimana',
                'knp': 'kenapa', 'emg': 'memang', 'udh': 'sudah', 'blm': 'belum'
            }
            self.slang_dict.update(alay_dict)
            print(f"Loaded {len(alay_dict)} additional slang words from new_kamusalay.csv")
        except FileNotFoundError:
            print(f"WARNING: {alay_path} not found. Using default slang_dict.")
            self.slang_dict = {'gk': 'tidak', 'gak': 'tidak'}


    def noise_removal(self, text):
        text = re.sub(r'http\S+|www\S+|https\S+', '', text, flags=re.MULTILINE)
        text = re.sub(r'@\w+|#\w+', '', text)
        text = re.sub(r'[^\w\s]', ' ', text)
        text = re.sub(r'\w*\d\w*', '', text)
        text = re.sub(r'\s+', ' ', text).strip()
        return text

    def case_folding(self, text):
        return text.lower()

    def tokenize(self, text):
        return text.split()

    def translate_slang(self, tokens):
        return [self.slang_dict.get(token, token) for token in tokens]

    def apply_stemming(self, tokens):
        return self.stemmer.stem(' '.join(tokens)).split()

    def remove_stopwords(self, tokens):
        return self.stopword_remover.remove(' '.join(tokens)).split()

    def preprocess(self, text):
        text = self.noise_removal(text)
        text = self.case_folding(text)
        tokens = self.tokenize(text)
        tokens = self.translate_slang(tokens)
        tokens = self.apply_stemming(tokens)
        tokens = self.remove_stopwords(tokens)
        return ' '.join(tokens)

# --- KELAS 2: IndoBERTClassifier ---
class IndoBERTClassifier(nn.Module):
    def __init__(self, model_name='indolem/indobert-base-uncased', num_classes=2, dropout_rate=0.3):
        super(IndoBERTClassifier, self).__init__()
        self.bert = AutoModel.from_pretrained(model_name)
        self.dropout = nn.Dropout(dropout_rate)
        self.classifier = nn.Linear(self.bert.config.hidden_size, num_classes)

    def forward(self, input_ids, attention_mask):
        outputs = self.bert(input_ids=input_ids, attention_mask=attention_mask)
        pooled_output = outputs.pooler_output
        output = self.dropout(pooled_output)
        logits = self.classifier(output)
        return logits


# --- KELAS 3: IntegratedAbusiveClassifier ---
class IntegratedAbusiveClassifier(nn.Module):
    def __init__(self, model_name='indolem/indobert-base-uncased', num_classes=2, dropout_rate=0.3):
        super(IntegratedAbusiveClassifier, self).__init__()
        self.preprocessor = IndonesianTextPreprocessor()
        self.tokenizer = AutoTokenizer.from_pretrained(model_name)
        self.bert_classifier = IndoBERTClassifier(model_name, num_classes, dropout_rate)
        self.label_encoder = None
        self.bad_words = []
        
    def _censor_bad_words(self, text):
        censored_text = text
        for word in self.bad_words:
            pattern = r'\b' + re.escape(word) + r'\b'
            replacement = '*' * len(word)
            censored_text = re.sub(pattern, replacement, censored_text, flags=re.IGNORECASE)
        return censored_text

    def predict(self, text: str):
        self.eval()
        model_device = next(self.bert_classifier.parameters()).device
        if self.label_encoder is None or not self.bad_words:
            raise RuntimeError("Model is not ready. Please set label_encoder and bad_words list before prediction.")
        processed_text = self.preprocessor.preprocess(text)
        encoding = self.tokenizer(processed_text, truncation=True, padding='max_length', max_length=128, return_tensors='pt')
        input_ids = encoding['input_ids'].to(model_device)
        attention_mask = encoding['attention_mask'].to(model_device)
        with torch.no_grad():
            logits = self.bert_classifier(input_ids, attention_mask)
            probabilities = torch.softmax(logits, dim=1)
            confidence, predicted_class_idx = torch.max(probabilities, dim=1)
        predicted_label = self.label_encoder.inverse_transform([predicted_class_idx.cpu().item()])[0]
        censored_text = text
        if predicted_label == 'abusive':
            censored_text = self._censor_bad_words(text)
        return {
            'original_text': text,
            'processed_text': processed_text,
            'predicted_label': predicted_label,
            'confidence': confidence.item(),
            'censored_text': censored_text
        }
