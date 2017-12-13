Received: from eggs.gnu.org ([2001:4830:134:3::10]:46486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eP30A-0003op-Rg
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 04:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eP30A-0003jt-4A
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 04:06:54 -0500
Date: Wed, 13 Dec 2017 09:06:30 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171213090630.fht4xlnvqhnxb7wj@starbug-vm.ie.oracle.com>
References: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171213051736.17755-1-f4bug@amsat.org>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org

Looks good to me, for all patches:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Wed, Dec 13, 2017 at 02:17:32AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>Philippe Mathieu-Daud=C3=A9 (4):
>  MAINTAINERS: add "hw/registerfields.h" in Register API entry
>  hw/registerfields: fix a typo in the FIELD() documentation
>  hw/registerfields: add 64-bit extract/deposit macros
>  hw/registerfields: add missing include
>
> include/hw/registerfields.h | 15 ++++++++++++++-
> MAINTAINERS                 |  1 +
> 2 files changed, 15 insertions(+), 1 deletion(-)
>
>--=20
>2.15.1
>
>
