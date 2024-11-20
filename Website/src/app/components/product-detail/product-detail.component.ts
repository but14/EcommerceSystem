import { Component, Input } from '@angular/core';
import { RouterLink } from '@angular/router';
import { HeaderComponent } from '../header/header.component';
import { FooterComponent } from '../footer/footer.component';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ActivatedRoute,ParamMap } from '@angular/router';
import { ProductServiceService } from '../../product-service.service';
import { UserServiceService } from '../../user-service.service';
import { Location } from '@angular/common';

@Component({
  selector: 'app-product-detail',
  standalone: true,
  imports: [RouterLink, HeaderComponent, FooterComponent, RouterOutlet,CommonModule],
  templateUrl: './product-detail.component.html',
  styleUrl: './product-detail.component.css'
})
export class ProductDetailComponent {
// 

constructor(
  private route:ActivatedRoute,
  private product_service : ProductServiceService,
  private user_service : UserServiceService,
  private _location: Location
){}

productId:string = ''
product_slug :string = ''
variant_id:string = ''
page_review :number = 1

product_infor:any
product_details:any[] =[]
product_imgs:any[] =[]
product_variants:any[] =[]
recent_reviews:any[] =[]
recent_images:any[] =[]

quantity:number = 1
token:string = localStorage.getItem("token") || ''


baseUrl: string = 'http://localhost:3000/public/images/'

ngOnInit(){
  // get data from param in URL
  this.route.paramMap.subscribe( (params:ParamMap)=>{
    this.product_slug = params.get("product_slug") || ''
    //console.log(this.product_slug);
  })
  // get data from query in URL
  this.route.queryParamMap.subscribe( param=>{
    this.productId = param.get("idProduct") || ''    
    this.product_service.detail_product(this.productId).subscribe( (data:any)=>{
      this.product_infor = data.data
      this.product_imgs = this.product_infor.product_imgs      
      this.product_details = this.product_infor.product_details
      this.product_variants = this.product_infor.product_variants
    })
  })

  this.getList_review()
}

formatDate(dateString: string): string {
  const date = new Date(dateString);
  const day = date.getDate().toString().padStart(2, '0');
  const month = (date.getMonth() + 1).toString().padStart(2, '0'); // Tháng bắt đầu từ 0
  const year = date.getFullYear(); return `${day}-${month}-${year}`;
  return `${day}-${month}-${year}`;
}

add_cart(){
  return this.user_service.add_cart(this.quantity,this.productId,this.variant_id,this.token).subscribe((data:any)=>{
    if(data.code == 200){        
      alert("Thêm thành công")
    }
    else if(data.code == 204){
      alert(data.error)
    }
    else{
      console.log(data.error);
    }
  })

}

// tăng giảm số lượng sản phẩm muốn mua
plusOrMinusQuantityProductOrder(isPlus: boolean): void {
  let currentQuantityProductOrder = document.getElementById('quantityOfProductOrderID') as HTMLInputElement;
  if(isPlus){
    (document.getElementById("quantityOfProductOrderID") as any).value = (currentQuantityProductOrder.value as any) - 0 + 1
    console.log(typeof(currentQuantityProductOrder.value))
    this.quantity = parseInt(currentQuantityProductOrder.value)
    //console.log(this.quantity);
  }else if((document.getElementById("quantityOfProductOrderID") as any).value != 1){
    (document.getElementById("quantityOfProductOrderID") as any).value = (currentQuantityProductOrder.value as any) - 0 - 1
    console.log(typeof(currentQuantityProductOrder.value))
    this.quantity = parseInt(currentQuantityProductOrder.value)
    //console.log(this.quantity);
  }
}

// đánh giá sao (1-5 sao) cho sản phẩm
starRatingForProduct(numberOfStars: string): void {
  let currentStarOfProduct = document.getElementById('starRatingOfProductID') as HTMLInputElement;
  let starRatingForm = document.getElementsByClassName('starRatingOfProduct')[0] as HTMLDivElement;
  if(numberOfStars != currentStarOfProduct.value){
    for(let i=1; i<=5; i++){
      if(i <= ((numberOfStars as any) - 0)){
        ((starRatingForm.childNodes[i]) as HTMLElement).className = "fa fa-star checked"
      }else{
        ((starRatingForm.childNodes[i]) as HTMLElement).className = "fa fa-star"
      }
    }
    (document.getElementById('starRatingOfProductID') as HTMLInputElement).value = numberOfStars
    console.log((document.getElementById('starRatingOfProductID') as HTMLInputElement).value)
  }else{
    for(let i=1; i<=5; i++){
      ((starRatingForm.childNodes[i]) as HTMLElement).className = "fa fa-star"
    }
    (document.getElementById('starRatingOfProductID') as HTMLInputElement).value = '0';
    console.log("Chưa đánh giá")
  }
}

// thay đổi hình chiếu sản phẩm khi click vào hình nhỏ
changeImageActive(orderOfImage: any): void { 
  let listImg = (document.getElementsByClassName('imageOfProductDetail') as any);
  ((document.getElementById('imageOfProductActivedID') as HTMLDivElement).childNodes[0] as HTMLImageElement).src = (document.getElementById(orderOfImage) as HTMLImageElement).src;
  for(let i of listImg){
    i.classList.remove('choosed');
  }
  (document.getElementById(orderOfImage) as HTMLElement).className = 'imageOfProductDetail choosed';
}
// thay đổi hình chiếu sản phẩm khi click vào variant
handleChooseVariant(event: any, variantId:string): void{
  let listBtnAddVariant = (document.getElementsByClassName('btnAddVariant') as any);
  ((document.getElementById('imageOfProductActivedID') as HTMLDivElement).childNodes[0] as HTMLImageElement).src = event.target.childNodes[0].src;
  for(let btn of listBtnAddVariant){
    btn.classList.remove('choosed');
  }
  event.target.classList.add('choosed');
  this.variant_id = variantId
}


getList_review() {
  this.product_service.getList_review(this.page_review , this.productId).subscribe( (data:any)=>{
    if(data.code == 200){
      console.log(data.data)
    }else{
      console.log(data.error);
    }
  })
}

// xử lý pagination
updatePage(page:number, event: any){
  let pagination = document.getElementById('paginationInProductDetailID');
  pagination?.childNodes.forEach(child => {
    (child as any).classList.remove('active');
  })
  // console.log(event.target)
  event.target.classList.add('active');
  // this._location.go(`/shop-page/${this.shop_name}?idSeller=${this.idSeller}&category_id=${this.category_id}&page=${page}&sortBy=${this.sortBy}`);
  // this.router.navigate([], { relativeTo: this.route, queryParams: { page: page }, queryParamsHandling: 'merge' });
  // this.update_product(page,this.sortBy,this.category_id)
}
}
