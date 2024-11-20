import { Component,inject } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AppServiceService } from '../../app-service.service';
import { UserServiceService } from '../../user-service.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, CommonModule],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent {
  constructor(
    private app_service : AppServiceService,
    private router : Router
  ){}

  length_cart:any

  ngOnInit(){
    this.app_service.getData().subscribe((data:any)=>{
      if(data.key == "cart_length"){
        this.length_cart = data.value
        // console.log(this.length_cart);
      }
      // console.log(data);
    })

  }


  searching(search_query:string){
    this.router.navigate(["/product-list"],{queryParams : { search_query : search_query}})
  }

  // open form search
  openFormSearchOnMobile(): void{
    
  }
}
