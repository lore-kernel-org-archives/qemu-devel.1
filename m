Received: from eggs.gnu.org ([2001:4830:134:3::10]:51362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqIka-0004ko-Mf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqIkV-0003L3-Qr
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:51:12 -0400
Date: Fri, 8 Sep 2017 15:51:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170908155042-mutt-send-email-mst@kernel.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830215523.25278-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/17] add missing entries in MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 06:55:06PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> I tried to have a more helpful ./scripts/get_maintainer.pl output, fill=
ing
> missing entries in MAINTAINERS.

For myself

Acked-by: Michael S. Tsirkin <mst@redhat.com>

pls merge through trivial or something like this.

> Regards,
>=20
> Phil.
>=20
> v2:
> - add R-b & A-b
> - clean ARM entries (Thomas Huth)
> - moved files: comment since which commit (Eric Blake)
> - drop inconsistent patches (default-configs.mak related to hw/machine,=
 no CPU)
> - drop unhappy patches (include/standard-headers/linux/*)
> - drop unreplied patches
>=20
> Philippe Mathieu-Daud=E9 (17):
>   MAINTAINERS: add missing ARM entries
>   MAINTAINERS: add missing Versatile PB entry
>   MAINTAINERS: add missing STM32 entry
>   MAINTAINERS: add missing entry for vhost
>   MAINTAINERS: add missing VMWare entry
>   MAINTAINERS: add missing Guest Agent entries
>   MAINTAINERS: add missing qcow2 entry
>   MAINTAINERS: add missing USB entry
>   MAINTAINERS: add missing PCI entries
>   MAINTAINERS: add missing SSI entries
>   MAINTAINERS: add missing entries for throttling infra
>   MAINTAINERS: add missing megasas test entry
>   MAINTAINERS: add missing AIO entry
>   MAINTAINERS: add missing entry for Generic Loader
>   MAINTAINERS: add missing Cryptography entry
>   MAINTAINERS: update docs/devel/ entries
>   MAINTAINERS: update docs/interop/ entries
>=20
>  MAINTAINERS | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.14.1
>=20
