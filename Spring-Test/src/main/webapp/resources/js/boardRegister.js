document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
});

//정규표현식을 이용한 생성자 함수를 만들기 시작은 반드시 \
// fileload시 형식제한 함수
const regExp = new RegExp("\.(exe|sh|bat|msi|dll|js)$"); //실행파일 막기
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$"); //이미지 파일
const maxSize = 1024*1024*20;  //20MB보다 큰지 체크

function fileSizeValidation(fileName, fileSize){
    if(regExp.test(fileName)){
        return 0;
    }else if(!regExpImg.test(fileName)){
        return 0;
    }else if(fileSize > maxSize){
        return 0;
    }else {
        return 1;
    }
}

document.addEventListener('change',(e)=>{
    if(e.target.id == "files"){
        //첨부되지 말아야하는 파일이 들어왔을 때 클릭되는것을 방지
        document.getElementById('regBtn').disabled = false; 
        //input type="file" element fileObject 객체로 리턴
        const fileObject = document.getElementById('files').files;
        console.log(fileObject);

        let div = document.getElementById('fileZone');
        div.innerHTML="";
        let ul ='<ul class="list-group list-group-flush">';
        let isOk = 1;
        for(let file of fileObject){
            let validResult = fileSizeValidation(file.name, file.size);
            isOk *= validResult; //모든 첨부파일의 결과가 1이여야 통과
            ul+=`<li class="list-group-item d-flex justify-content-between align-items-start">`;
            //업로드 가능여부 표시
            ul+= `${validResult ? '<div class="fw-bold">업로드가능' 
                : '<div class="fw-bold text-danger">업로드불가'}</div>`;
            ul+=`${file.name}`;
            ul+=`<span class="badge bg-${validResult ? 'success':'danger'} rounded-pill">
                ${file.size} Bytes</span></li>`;
        }
        ul+= `</ul>`;
        div.innerHTML= ul;

        if(isOk == 0){
            document.getElementById('regBtn').disabled = true;
        }
    }
})