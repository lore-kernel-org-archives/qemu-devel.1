Received: from eggs.gnu.org ([2001:4830:134:3::10]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1ePBUN-0002uc-HP
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1ePBUM-0005de-OX
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:10:39 -0500
Date: Thu, 14 Dec 2017 01:10:09 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20171213181009.GM26889@toto>
References: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171213051736.17755-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/4] Trivial changes in "registerfields.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

On Wed, Dec 13, 2017 at 02:17:32AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Philippe Mathieu-Daud=E9 (4):
>   MAINTAINERS: add "hw/registerfields.h" in Register API entry
>   hw/registerfields: fix a typo in the FIELD() documentation
>   hw/registerfields: add 64-bit extract/deposit macros
>   hw/registerfields: add missing include
>=20
>  include/hw/registerfields.h | 15 ++++++++++++++-
>  MAINTAINERS                 |  1 +
>  2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
