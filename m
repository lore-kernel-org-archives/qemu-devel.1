Received: from eggs.gnu.org ([209.51.188.92]:46105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hEEIH-0005Ii-E3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hEEIG-0000sg-HB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:33:41 -0400
Received: from m12-14.163.com ([220.181.12.14]:43735)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hEEIF-0000ga-Ac
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:33:40 -0400
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Wed, 10 Apr 2019 22:33:24 +0800
Message-Id: <5CADFEB7.01C57B.25694@m12-14.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?Questions_about_acpi_interrupt_link_device?=
 =?utf-8?b?J3Mg4oCYX1BSUycgZmllbGQ=?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liq3ea@gmail.com" <liq3ea@gmail.com>

Hi all,

I see the link device =E2=80=98_PRS=E2=80=99  uses irq line 5, 10, 11 in =
=E2=80=98build_link_dev=E2=80=99 function.
But I never see the 5 lines uses in the guest, just uses 10 and 11.=20
Why this happen?  Maybe related with the guest?

Thanks,
Li Qiang
