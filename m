Received: from eggs.gnu.org ([2001:4830:134:3::10]:35714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dZhBY-0002rn-G8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dZhBR-00045a-Lc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:30:24 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:37385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dZhBR-000456-Ft
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:30:17 -0400
Received: by mail-io0-x244.google.com with SMTP id p5so4443292ioo.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 10:30:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <56c4d877-58e8-b8ac-cc7f-e6cde5ddfa16@redhat.com>
Date: Mon, 24 Jul 2017 13:30:14 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <69D48A72-93F1-4314-BD0E-E62CC03B4C08@gmail.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<56c4d877-58e8-b8ac-cc7f-e6cde5ddfa16@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


> On Jul 24, 2017, at 12:43 PM, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On 07/21/2017 05:06 AM, Igor Mammedov wrote:
>> On Thu, 20 Jul 2017 21:29:33 +0200
>> Phil Dennis-Jordan <lists@philjordan.eu> wrote:
>>> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>>> <programmingkidx@gmail.com> wrote:
>>>> I noticed that Windows 2000 does not boot up in QEMU recently. =
After bisecting the issue I found the offending commit:
>> w2k is very ancient (and long time EOLed), I can't even download it =
from msdn to test
>> (oldest available is XP)
>> do we really care about it?
>=20
> Red Hat: "No, not really."
> FOSS: "Yes, of course!"
>=20
> Half the fun of QEMU (see also: QEMU Advent Calendar) is running old =
software. Technology moves so fast that even software from just 17 years =
ago is becoming impossible to run.
>=20
> For historical and archival purposes it is absolutely of interest to =
be able to run one of Microsoft's most popular operating systems.
>=20
> Of course, it's not particularly high on anyone's list who is getting =
paid to tend to QEMU, of course.
>=20
> =E2=80=94js

Well said.
