var TitleView = Class.create();
TitleView.prototype = {

  initialize: function(element) {
    this.view = $(element);
    this.view.style.position = 'relative';
    this.view.roundCorners();
    this.books = this.view.getElementsByClassName('book');
    this.selected = this.view.getElementsByClassName('selected')[0];
    for (var i = 0; i < this.books.length; i++) { this.setupBook(this.books[i]); }
    this.selectBook(this.books[0]);
  },
  
  getBookDetailsTop: function(book) {
    var viewHeight = Element.getHeight(this.view);
    var top =  book.thumbnail.offsetTop + 95 - (book.detailsHeight / 2);
    if (top + book.detailsHeight + 15 > viewHeight) { top = viewHeight - book.detailsHeight - 15; }
    if (top < 24) { top = 24; }
    return top;
  },
  
  selectBook: function(book) {
    if (this.selected != book) {
      if (this.selected != null) {
        this.selected.className = this.selected.className.replace(/\s*\bselected\b\s*/, ' ');
        this.selected.details.style.display = "none";
      }
      this.selected = book;
      this.selected.details.style.top = this.getBookDetailsTop(this.selected) + 'px';
      this.selected.details.style.display = "block";
      this.selected.className = this.selected.className.replace(/\s*\bselected\b|$/, ' selected');
      this.view.setStyle({minHeight: book.detailsHeight + 40 + 'px'});
      this.view.down('div', 9).setStyle({minHeight: book.detailsHeight + 40 + 'px'});
    }
  },
  
  onMouseOverBook: function(book, event) {
    this.selectBook(book);
  },
  
  setupBook: function(book) {
    book.thumbnail = book.getElementsByClassName('thumbnail')[0];
    book.details = book.getElementsByClassName('details')[0];
    book.detailsHeight = Element.getHeight(book.details);
        
    var view = this;
    Event.observe(book, 'mouseover', function(event) { view.onMouseOverBook(this, event) }.bindAsEventListener(book));
  }

};