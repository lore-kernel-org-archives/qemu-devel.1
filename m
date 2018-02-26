Received: from eggs.gnu.org ([2001:4830:134:3::10]:58501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eqD48-00023I-C9
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eqD44-0000jK-DD
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:19:16 -0500
Received: from smtp65.cstnet.cn ([159.226.251.65]:41115 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eqD43-0000ib-Pa
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:19:12 -0500
Date: Mon, 26 Feb 2018 15:19:04 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <eff138d4-b83b-80f0-34c7-90bbf002f0b3@redhat.com>
References: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1519533358-13759-4-git-send-email-suhang16@mails.ucas.ac.cn>
	<eff138d4-b83b-80f0-34c7-90bbf002f0b3@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <501ee02e.163cc.161d0faaddc.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v4 RFC 3/3] util/uri.c: wrap single
 statement blocks with braces {}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thomas huth <thuth@redhat.com>
Cc: boxafox@163.com, qemu-devel@nongnu.org, stefan hajnoczi <stefanha@redhat.com>

CkkgY2FuJ3QgYmUgdG9vIGhhcHB5IHRvIGtub3cgbXkgZmlyc3QgcGF0Y2ggZ2V0IGFjY2VwdGVk
ISBeX14KSSBob3BlIEkgY2FuIG1ha2UgbW9yZSBjb250cmlidXRpb25zIHRvIGNvbW11bml0eSEK
Cgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJUaG9tYXMgSHV0aCIgPHRo
dXRoQHJlZGhhdC5jb20+Cj4gU2VudCBUaW1lOiAyMDE4LTAyLTI2IDE0OjQ5OjQ2IChNb25kYXkp
Cj4gVG86ICJTdSBIYW5nIiA8c3VoYW5nMTZAbWFpbHMudWNhcy5hYy5jbj4sIGJveGFmb3hAMTYz
LmNvbQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcsICJTdGVmYW4gSGFqbm9jemkiIDxzdGVm
YW5oYUByZWRoYXQuY29tPgo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0IFJG
QyAzLzNdIHV0aWwvdXJpLmM6IHdyYXAgc2luZ2xlIHN0YXRlbWVudCBibG9ja3Mgd2l0aCBicmFj
ZXMge30KPiAKPiBPbiAyNS4wMi4yMDE4IDA1OjM1LCBTdSBIYW5nIHdyb3RlOgo+ID4gRm9yIHRo
aXMgcGF0Y2gsIHVzaW5nIGN1cmx5IGJyYWNlcyB0byB3cmFwIGBpZmAgYHdoaWxlYCBgZWxzZWAg
c3RhdGVtZW50cywKPiA+IHdoaWNoIG9ubHkgaG9sZCBzaW5nbGUgc3RhdGVtZW50LiBGb3IgZXhh
bXBsZToKPiA+ICcnJwo+ID4gaWYgKGNvbmQpCj4gPiAgICAgc3RhdGVtZW50Owo+ID4gJycnCj4g
PiB0bwo+ID4gJycnCj4gPiBpZiAoY29uZCkgewo+ID4gICAgIHN0YXRlbWVudDsKPiA+IH0KPiA+
ICcnJwo+ID4gCj4gPiBBbmQgdXNpbmcgdHJpY2tzIHRoYXQgY29tcGFyZSB0aGUgZGlzYXNzZW1i
bGllcyBiZWZvcmUgYW5kIGFmdGVyCj4gPiBjb2RlIGNoYW5nZXMsIHRvIG1ha2Ugc3VyZSBjb2Rl
IGxvZ2ljIGlzbid0IGNoYW5nZWQ6Cj4gPiAnJycKPiA+IGdpdCBjaGVja291dCBtYXN0ZXIKPiA+
IG1ha2UgdXRpbC91cmkubwo+ID4gc3RyaXAgdXRpbC91cmkubwo+ID4gb2JqZHVtcCAtRHJ4IHV0
aWwvdXJpLm8gPiAvdG1wL3VyaS1tYXN0ZXIudHh0Cj4gPiBnaXQgY2hlY2tvdXQgY2xlYW51cGJy
YW5jaAo+ID4gbWFrZSB1dGlsL3VyaS5vCj4gPiBzdHJpcCB1dGlsL3VyaS5vCj4gPiBvYmpkdW1w
IC1EcnggdXRpbC91cmkubyA+IC90bXAvdXJpLWNsZWFudXAudHh0Cj4gPiBkaWZmIC11IC90bXAv
dXJpLSoudHh0Cj4gPiAnJycKPiA+IAo+ID4gV2l0aCB0aGF0LCBhbGwgY29tcGxhaW50cyByYWlz
ZWQgYnkgY2hlY2twYXRjaC5wbCBoYXZlIGJlZW4gc3VwcHJlc3NlZC4gIAo+ID4gCj4gPiBTdWdn
ZXN0ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPgo+ID4gU3VnZ2VzdGVkLWJ5
OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFN1IEhh
bmcgPHN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+Cj4gPiAtLS0KPiA+ICB1dGlsL3VyaS5jIHwg
NDYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjk0IGluc2VydGlvbnMoKyksIDE2OSBkZWxl
dGlvbnMoLSkKPiAKPiBSZXZpZXdlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+
Cj4gCj4gSSd2ZSBhbHNvIGNoZWNrZWQgYWdhaW4gd2l0aCB0aGUgIm9iamR1bXAiIHRyaWNrIHRo
YXQgdGhlcmUgYXJlIG5vCj4gZGlmZmVyZW5jZXMgaW4gdGhlIGdlbmVyYXRlZCBjb2RlLCBhbmQg
aW5kZWVkLCBsb29rcyBnb29kIG5vdywgc28gSQo+IHRoaW5rIEkgY2FuIGFsc28gc2F5Ogo+IAo+
IFRlc3RlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+Cj4gCj4gVGhhbmsgeW91
IHZlcnkgbXVjaCBmb3IgY2xlYW5pbmcgdXAgdGhhdCBodWdlIGZpbGUhCj4gCj4gIFRob21hcwo=
