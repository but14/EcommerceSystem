import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { HeaderComponent } from '../header/header.component';
import { FooterComponent } from '../footer/footer.component';
import { RouterOutlet } from '@angular/router';
import { ProductServiceService } from '../../product-service.service';
import { UserServiceService } from '../../user-service.service';
import { ActivatedRoute } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-product-list',
  standalone: true,
  imports: [RouterLink, HeaderComponent, FooterComponent, RouterOutlet,CommonModule],
  templateUrl: './product-list.component.html',
  styleUrl: './product-list.component.css'
})
export class ProductListComponent {
  constructor(
    private product_service :ProductServiceService,
    private user_service : UserServiceService,
    private route : ActivatedRoute
  ){}

  sortBy:string = ''
  page:number = 1
  list_product : any[] = []

  baseUrl:string= 'http://localhost:3000/public/images/'

  ngOnInit(){
    let search_query = this.route.snapshot.queryParamMap.get("search_query") || ''
    search_query = search_query.toString()
    this.user_service.searching(search_query,this.sortBy,this.page).subscribe((data)=>{
      if(data.code == 200){
        this.list_product = data.data
        console.log(this.list_product);
      }
      else{
        console.log(data.error);
      }
    })
  }

  productByCondition(page:number,sortBy:string,event:any){
    
  }

  // Mở Bộ lọc sản phẩm 
  openFilterProductList(): void{
    (document.getElementById('leftOfProductListID') as HTMLDivElement).style.transform = 'translateX(0px)';
  }
  // Đóng Bộ lọc sản phẩm 
  closeFilterProductList(): void{
    (document.getElementById('leftOfProductListID') as HTMLDivElement).style.transform = 'translateX(-500px)';
  }


}
