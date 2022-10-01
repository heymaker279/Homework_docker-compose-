from django.contrib import admin
from django.forms import BaseInlineFormSet

# Register your models here.
from logistic.models import Stock, Product, StockProduct


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ['title', 'description']


class StockProductInline(admin.TabularInline):
    model = StockProduct


@admin.register(Stock)
class StockAdmin(admin.ModelAdmin):
    list_display = ['address']
    inlines = [StockProductInline]
