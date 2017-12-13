Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePAnD-0006kx-9u
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePAnC-0005Rx-CG
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:26:03 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213090630.fht4xlnvqhnxb7wj@starbug-vm.ie.oracle.com>
References: <20171213051736.17755-1-f4bug@amsat.org>
	<20171213090630.fht4xlnvqhnxb7wj@starbug-vm.ie.oracle.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 13 Dec 2017 09:25:28 -0800
Message-ID: <CAKmqyKPxuk5ifyCWvWVTyJvGzjsZ4reT-SFLNuG3_0nvn3CQ+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Trivial changes in "registerfields.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 1:06 AM, Darren Kenny <darren.kenny@oracle.com> wro=
te:
> Looks good to me, for all patches:
>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Same, for all four patches.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

>
> Thanks,
>
> Darren.
>
>
> On Wed, Dec 13, 2017 at 02:17:32AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>>
>> Philippe Mathieu-Daud=C3=A9 (4):
>>  MAINTAINERS: add "hw/registerfields.h" in Register API entry
>>  hw/registerfields: fix a typo in the FIELD() documentation
>>  hw/registerfields: add 64-bit extract/deposit macros
>>  hw/registerfields: add missing include
>>
>> include/hw/registerfields.h | 15 ++++++++++++++-
>> MAINTAINERS                 |  1 +
>> 2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> --
>> 2.15.1
>>
>>
>
