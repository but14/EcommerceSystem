import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HomeSuggestComponent } from './home-suggest.component';

describe('HomeSuggestComponent', () => {
  let component: HomeSuggestComponent;
  let fixture: ComponentFixture<HomeSuggestComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HomeSuggestComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(HomeSuggestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
