Received: from eggs.gnu.org ([209.51.188.92]:45720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2wr0-0002EV-IW
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2wqy-00060K-TD
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:42:54 -0400
Received: from m13-139.163.com ([220.181.13.139]:33370)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2wqy-0005wY-2K
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:42:52 -0400
Date: Sun, 10 Mar 2019 19:27:14 +0800 (CST)
From: =?GBK?B?wO7Hvw==?= <liq3ea@163.com>
In-Reply-To: <a697a5a0-54e5-0a2f-8d6c-e204a095ff6c@redhat.com>
References: <20190102074114.26988-1-liq3ea@163.com>
	<a697a5a0-54e5-0a2f-8d6c-e204a095ff6c@redhat.com>
MIME-Version: 1.0
Message-ID: <59a23906.6c71.169675b5d10.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] qom: cpu: destroy work_mutex in
 cpu_common_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: ehabkost@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com, cota@braap.org, philmd@redhat.com, qemu-devel@nongnu.org

SGkgUGFvbG8sCgpXaGF0J3MgdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNoPyBJIGRvbid0IHNlZSBp
dCBpbiB1cHN0cmVhbS4KCgpUaGFua3MsCkxpIFFpYW5nCgoKQXQgMjAxOS0wMS0wOCAwNzo0MTow
OSwgIlBhb2xvIEJvbnppbmkiIDxwYm9uemluaUByZWRoYXQuY29tPiB3cm90ZToKPk9uIDAyLzAx
LzE5IDA4OjQxLCBMaSBRaWFuZyB3cm90ZToKPj4gQ29tbWl0IDM3NjY5MmI5ZGM2KGNwdXM6IHBy
b3RlY3Qgd29yayBsaXN0IHdpdGggd29ya19tdXRleCkKPj4gaW5pdGlhbGl6ZSBhIHdvcmtfbXV0
ZXggaW4gY3B1X2NvbW1vbl9pbml0Zm4sIGhvd2V2ZXIgZm9yZ2V0Cj4+IHRvIGRlc3Ryb3kgaXQu
IFRoaXMgd2lsbCBjYXVzZSByZXNvdXJjZSBsZWFrIHdoZW4gaG90dW5wbHVnIGNwdQo+PiBvciBo
b3RwbHVnIGNwdSBmYWlscy4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpIFFpYW5nIDxsaXEzZWFA
MTYzLmNvbT4KPj4gLS0tCj4+ICBxb20vY3B1LmMgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL3FvbS9jcHUuYyBiL3FvbS9jcHUu
Ywo+PiBpbmRleCA5YWQxMzcyZDU3Li4zNjdlYmY5ZDYxIDEwMDY0NAo+PiAtLS0gYS9xb20vY3B1
LmMKPj4gKysrIGIvcW9tL2NwdS5jCj4+IEBAIC0zODAsNiArMzgwLDkgQEAgc3RhdGljIHZvaWQg
Y3B1X2NvbW1vbl9pbml0Zm4oT2JqZWN0ICpvYmopCj4+ICAKPj4gIHN0YXRpYyB2b2lkIGNwdV9j
b21tb25fZmluYWxpemUoT2JqZWN0ICpvYmopCj4+ICB7Cj4+ICsgICAgQ1BVU3RhdGUgKmNwdSA9
IENQVShvYmopOwo+PiArCj4+ICsgICAgcWVtdV9tdXRleF9kZXN0cm95KCZjcHUtPndvcmtfbXV0
ZXgpOwo+PiAgfQo+PiAgCj4+ICBzdGF0aWMgaW50NjRfdCBjcHVfY29tbW9uX2dldF9hcmNoX2lk
KENQVVN0YXRlICpjcHUpCj4+IAo+Cj5RdWV1ZWQsIHRoYW5rcy4KPgo+UGFvbG8K
