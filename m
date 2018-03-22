Received: from eggs.gnu.org ([2001:4830:134:3::10]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eyuFv-0003ps-2N
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eyuFr-0007rw-4y
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:03:23 -0400
Received: from smtp64.cstnet.cn ([159.226.251.64]:58297 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eyuFq-0007mq-Ed
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:03:19 -0400
Date: Thu, 22 Mar 2018 15:03:03 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <dca9a53.33fd5.1624c84a277.Coremail.suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] Should we check arguments for function `from_bcd` and
 `to_bcd`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

V2hlbiBJIHdhcyByZWFkaW5nICdxZW11L2h3L3RpbWVyL200OHQ1OS5jJyhMaW5lOjMyOCkgYW5k
IHJ1biB3aXRoCmBtYWtlIGNoZWNrLXF0ZXN0LXBwY2AsCkkgZm91bmQgd2hlbiB3cml0ZSBhbiBp
bnZhbGlkIHZhbHVlIDB4YyB0byBhZGRyZXNzIDB4MUZGRiwKYGZyb21fYmNkYCByZXR1cm4gMTIg
aW5zdGVhZCBvZiByYWlzaW5nIGFuIGV4Y2VwdGlvbihvciBlcnJvcikuCgoiIiIocWVtdS9ody90
aW1lci9tNDh0NTkuYykKICAgIGNhc2UgMHgxRkZGOgogICAgY2FzZSAweDA3RkY6CiAgICAgICAg
LyogeWVhciAqLwogICAgdG1wID0gZnJvbV9iY2QodmFsKTsKICAgIGlmICh0bXAgPj0gMCAmJiB0
bXAgPD0gOTkpIHsKIiIiCgoKIiIiKHFlbXUvaW5jbHVkZS9xZW11L2JjZC5oKQovKiBDb252ZXJ0
IGEgYnl0ZSBiZXR3ZWVuIGJpbmFyeSBhbmQgQkNELiAgKi8Kc3RhdGljIGlubGluZSB1aW50OF90
IHRvX2JjZCh1aW50OF90IHZhbCkKewogICAgcmV0dXJuICgodmFsIC8gMTApIDw8IDQpIHwgKHZh
bCAlIDEwKTsKfQoKc3RhdGljIGlubGluZSB1aW50OF90IGZyb21fYmNkKHVpbnQ4X3QgdmFsKQp7
CiAgICByZXR1cm4gKCh2YWwgPj4gNCkgKiAxMCkgKyAodmFsICYgMHgwZik7Cn0KIiIiCgpTdSBI
YW5n
