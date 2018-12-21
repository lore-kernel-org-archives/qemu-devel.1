Received: from eggs.gnu.org ([2001:4830:134:3::10]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gaFyi-0000lY-N6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gaFyZ-000891-5G
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:16:13 -0500
Received: from m13-112.163.com ([220.181.13.112]:23214)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gaFyY-00080v-Ch
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:16:07 -0500
Date: Fri, 21 Dec 2018 16:00:49 +0800 (CST)
From: tugouxp  <13824125580@163.com>
In-Reply-To: <38696e96-5047-b076-40ab-e650bb8e1f02@redhat.com>
References: <130d7419.4ba1.167ce7b9ed6.Coremail.13824125580@163.com>
	<38696e96-5047-b076-40ab-e650bb8e1f02@redhat.com>
MIME-Version: 1.0
Message-ID: <31f6df3f.c713.167cfc7fc00.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] is the "tcg translation" necessary when the "kvm
 acceleration" emulation mode enabled?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

bXVjaCBhcHByZWNpYXRlIQoKOikKCgoKCgoKCgpBdCAyMDE4LTEyLTIxIDE0OjMzOjA4LCAiUGFv
bG8gQm9uemluaSIgPHBib256aW5pQHJlZGhhdC5jb20+IHdyb3RlOgo+PiBzY2VuYXJpbyAxOiAg
ZGlkIHRoZSB0Y2cgdHJhbnNsYXRpb24gbmVlZCB0byBiZSBkb25lIGluIHRoaXMgY2FzZSBub3cK
Pj4gdGhhdCB0aGUgaG9zdCBhbmQgdGFyZ2V0IGFyY2ggaXMgdGhlIHNhbWU/ICBvciAgbGV0IHRo
ZSBrdm0gZW11bGF0aW9uCj4+IHRoZSBzeXN0ZW0gd2l0IHRoZSBvcmlnaW5hbCBpbnN0cnVjdGlv
bnMgd2l0aCBvdXQgdGhlIFRDRwo+PiB0cmFuc2xhdGlvbgo+Cj5UQ0cgaXMgdHVybmVkIG9mZiB3
aGVuIEtWTSBpcyBlbmFibGVkLiAgVGhlIGNvZGUgZm9yIFRDRyBkb2VzIG5vdCBydW4gYXQKPmFs
bC4KPgo+PiBzY2VuYXJpbyAyOiAgIHRoZSBwcmUgY29uZGl0aW9uIGlzIHNhbWUgd2l0aCBzY2Vu
YXJpbyAxIGV4Y2VwdCB0aGUga3ZtCj4+IGlzIGRpc2FibGWjvyBzbyAsaW4gdGhpcyBzY2VuYXJp
bywgdGhlIFRDRyBtdXN0IGJlIHVzZWQgaW4gb3JkZXIgdG8KPj4gdGhlIHB1cmUgc29mdHdhcmUg
ZW11bGF0aW9uIHdpdGhvdXQgYWNjZWxlcmF0aW9uPwo+Cj5Db3JyZWN0LiAgSW4gdGhpcyBjYXNl
IEtWTSBpcyB0dXJuZWQgb2ZmLiAgVGhlIGNhcGFiaWxpdGllcyBvZiB0aGUKPmVtdWxhdGVkIENQ
VSB3aWxsIF9ub3RfIGJlIHdoYXQgeW91IGhhdmUgaW4geW91ciBob3N0IHByb2Nlc3NvciwgYnV0
Cj5yYXRoZXIgd2hhdCBRRU1VIGltcGxlbWVudHMuICBGb3IgZXhhbXBsZSwgeW91IHdpbGwgZ2V0
IG5vIEFWWC4KPgo+PiBzY2VuYXJpbyAzOiAgaW4gdGhpcyBzY2VuYXJpbywgdGhlIGhvc3QgYW5k
IHRhcmdldCBhcmNoIGlzIG5vdCB0aGUKPj4gc2FtZSwgc28gaG93IHRvIHVzZSB0aGUgImt2bSBt
ZWNoYWluc2ltIiBpbiB0aGlzIGNhc2U/ICBzbyB0aGUKPj4gaW5zdHJ1Y3Rpb25zIGZlZWQgdG8g
dGhlIGt2bSBtb2R1bGUgdG8gcnVuIG11c3QgYmUgdHJhbnNsYXRlZCBCeSBUQ0cKPj4gbW9kdWxl
PyByaWdodD8KPgo+S1ZNIGNhbm5vdCBiZSB1c2VkIGluIHRoaXMgY2FzZTsgS1ZNIGlzIG9ubHkg
ZW5hYmxlZCB3aGVuIHRoZSBob3N0IGFuZAo+dGhlIHRhcmdldCBhcmUgdGhlIHNhbWUuCj4KPlBh
b2xvCj4KPk9uIDIxLzEyLzE4IDAyOjU3LCB0dWdvdXhwIHdyb3RlOgo+PiBoaSBmb2xrczoKPj4g
ICAgIGkgYW0gdmVyeSBwdXp6bGVkIGFib3V0IHRoZSByZWxhdGlvbnNoaXAgYmV0d2VlbiAidGFy
Z2V0IGNwdSBpbnN0cnVjdGlvbiIgIHRyYW5zbGF0ZWQgdG8gaG9zdCBpbnN0cnVjdGlvbnMgdGhy
b3VnaCBUQ0cgbW9kdWxlIGFuZCB0aGUgImt2bSIgYWNjZWxlcmF0aW9uIiBtb2RlLgo+PiAKPj4g
Cj4+IHRoaW5rIGFib3V0IHRocmVlIHNjZW5hcmlvIG9mIGVtdWxhdGlvbjoKPj4gc2NlbmFyaW8g
MSwgMiBhbmQgMyBhcyBmb2xsb3dzOgo+PiAKPj4gMS4gdGFyZ2V0IGNwdTogeDg2XzY0LAo+PiAg
ICAgaG9zdCBjcHU6ICAgeDg0XzY0LAo+PiAgICAgZW11bGF0aW9uIE9TOiAgIHVidW50dV9kZXNr
dG9wX2FtZDY0Lmlzbwo+PiAgICAga3ZtOiAgZW5hYmxlZC4KPj4gCj4+IAo+PiAyLiB0YXJnZXQg
Y3B1OiB4ODZfNjQsCj4+IAo+PiAgICAgaG9zdCBjcHU6ICAgeDg0XzY0LAo+PiAKPj4gICAgIGVt
dWxhdGlvbiBPUzogICB1YnVudHVfZGVza3RvcF9hbWQ2NC5pc28KPj4gICAgIGt2bTogIGRpc2Fi
bGVkLgo+PiAKPj4gCj4+IDMuIHRhcmdldCBjcHUgIHg4Nl82NCwKPj4gICAgIGhvc3QgY3B1OiAg
YXJtdjgKPj4gICAgIGVtdWxhdGlvbk9TOiB1YnVudHVfZGVza3RvcF9hbWQ2NC5pc28KPj4gICAg
IGt2bTogIGVuYWJsZWQK
