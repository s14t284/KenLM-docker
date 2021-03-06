N = 3
INPUT_PATH = target.txt
OUTPUT_PATH = kenlm_model/model.lm
BINARY_PATH = kenlm_model/model.lm.bin
SENTENCE = "This is a pen ."

init-kenlm-docker:
	docker build --network=host --no-cache -t kenlm-image:latest .

train-language-model:
	docker run --rm -i -v ${PWD}:/home kenlm-image /kenlm/build/bin/lmplz -o ${N} < ${INPUT_PATH} > ${OUTPUT_PATH}

generate-binary-lm:
	docker run --rm -i -v ${PWD}:/home kenlm-image /kenlm/build/bin/build_binary -T tmp/ ${OUTPUT_PATH} ${BINARY_PATH}

predict-with-language-model:
	docker run -i --rm -v ${PWD}:/home kenlm-image /home/predict.py /home/${OUTPUT_PATH} ${SENTENCE}
