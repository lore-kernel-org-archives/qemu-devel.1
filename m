Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLtc-0004xf-JN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLtb-0008Gc-Q0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:24:52 -0400
References: <20170910171557.12689-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c1bf125-1431-cdf7-3e4b-7fb95113acfc@redhat.com>
Date: Mon, 11 Sep 2017 12:24:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170910171557.12689-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update email,
 add missing test entry for megasas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Hannes Reinecke <hare@suse.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/09/2017 19:15, Philippe Mathieu-Daud=C3=A9 wrote:
> and update maintainer email address
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Hannes Reinecke replied:
> I'm currently on vacation with no internet access, but will be happy to=
 answer your mail once I'm back at work on Sep, 12th.
>=20
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36eeb42d19..371e23a9ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1101,11 +1101,12 @@ F: hw/block/nvme*
>  F: tests/nvme-test.c
> =20
>  megasas
> -M: Hannes Reinecke <hare@suse.de>
> +M: Hannes Reinecke <hare@suse.com>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: hw/scsi/megasas.c
>  F: hw/scsi/mfi.h
> +F: tests/megasas-test.c
> =20
>  Network packet abstractions
>  M: Dmitry Fleytman <dmitry@daynix.com>
>=20

Queued, thanks.

Paolo
