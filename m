Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db1Sy-0007iY-4G
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db1Sx-0007V0-Bv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:52 -0400
Date: Fri, 28 Jul 2017 11:12:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170728091222.GA3983@localhost.localdomain>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-20-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170728053610.15770-20-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/47] MAINTAINERS: add missing qcow2 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

Am 28.07.2017 um 07:35 hat Philippe Mathieu-Daud=E9 geschrieben:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b83dac812..2dcdda4cd5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1856,6 +1856,7 @@ M: Max Reitz <mreitz@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/qcow2*
> +F: docs/interop/qcow2.txt

Acked-by: Kevin Wolf <kwolf@redhat.com>
