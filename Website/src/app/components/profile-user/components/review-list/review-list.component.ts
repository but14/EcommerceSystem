import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { UserServiceService } from '../../../../user-service.service';
import { ProductServiceService } from '../../../../product-service.service';
import { Router } from '@angular/router';
import { RouterLink } from '@angular/router';




@Component({
  selector: 'app-review-list',
  standalone: true,
  imports: [CommonModule,RouterLink],
  templateUrl: './review-list.component.html',
  styleUrl: './review-list.component.css'
})
export class ReviewListComponent {
  constructor(
    private user_service    : UserServiceService,
    private product_service : ProductServiceService,
    private router : Router,
  ){}

  token:string = localStorage.getItem("token") || ''
  page :number = 1
  detail_order : any[] = [] 
  list_order : any[] = []
  product_details:any[] =[]
  order_status : string = "Successfull"
  // order_status : string = "Processing"


  baseUrl: string = 'http://localhost:3000/public/images/'


  ngOnInit(){
    this.user_service.getList_order(this.token,this.page, this.order_status).subscribe((data:any)=>{
      if(data.code == 200 ){
        // console.log(data.data);
        // 1 list order là 1 mảng chứa các thông tin về order .
        // và có order_details là thông tin chi tiết của sản phẩm mua . và có product_details để populate tới product có trong order_details
        this.list_order = data.data

        this.list_order.forEach(element=>{
          this.detail_order = element.order_details
        })

        this.detail_order.forEach((element,index)=>{
          // this.user_service.getList_order_filter(element.product_id, element.variant_id).subscribe((data:any)=>{
          //   this.detail_order[index].product_details = data.data // add property for object
          //   // this.product_details.push(data.data)
          // })
          // console.log(this.product_details);
        })
        console.log(this.list_order);
        console.log(this.detail_order);
        console.log(this.product_details);

      }else{
        console.log(data.error);
      }
    })
  }

  // review_page(product_id:string,variant_id:string,order_id:string,product_sort:number){
    review_page(product_id:string,variant_id:string,order_id:string){
    this.router.navigate(["/review"],
      { queryParams : {
        product_id  : product_id,
        variant_id  : variant_id ,
        order_id    : order_id,
      }
    })
  }
}
