import { Component } from '@angular/core';
import { UserInfoComponent } from './components/user-info/user-info.component'; 
import { OrderHistoryComponent } from './components/order-history/order-history.component'; 
import { ReviewListComponent } from './components/review-list/review-list.component';
import { RouterOutlet, RouterLink } from '@angular/router';
import { HeaderComponent } from '../header/header.component';
import { FooterComponent } from '../footer/footer.component';

@Component({
  selector: 'app-profile-user',
  standalone: true,
  imports: [RouterOutlet, RouterLink, UserInfoComponent, OrderHistoryComponent, HeaderComponent, FooterComponent,ReviewListComponent],
  templateUrl: './profile-user.component.html',
  styleUrl: './profile-user.component.css'
})
export class ProfileUserComponent {

}
