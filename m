Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYaM4-0003CL-AV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYaM0-0003pB-DL
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:00:40 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dYaM0-0003oP-8i
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:00:36 -0400
Received: by mail-it0-x243.google.com with SMTP id t6so3941469itb.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 09:00:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.85963.1500629384.22737.qemu-devel@nongnu.org>
Date: Fri, 21 Jul 2017 12:00:31 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0374D72-B125-4566-9D99-4C5E0268219F@gmail.com>
References: <mailman.85963.1500629384.22737.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>


> On Jul 21, 2017, at 5:29 AM, qemu-devel-request@nongnu.org wrote:
>=20
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> On Thu, 20 Jul 2017 21:29:33 +0200
> Phil Dennis-Jordan <lists@philjordan.eu> wrote:
>=20
>> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>> <programmingkidx@gmail.com> wrote:
>>> I noticed that Windows 2000 does not boot up in QEMU recently. After =
bisecting the issue I found the offending commit:
> w2k is very ancient (and long time EOLed), I can't even download it =
from msdn to test
> (oldest available is XP)

If you really need to download Windows 2000, there may be other avenues =
you may want to try.=20

> do we really care about it?

Yes. It is a great operating system. Very light weight, fast, and =
stable. The perfect operating system to use in an emulator.=
