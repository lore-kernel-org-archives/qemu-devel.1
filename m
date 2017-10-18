Received: from eggs.gnu.org ([2001:4830:134:3::10]:49772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4n5b-0003NR-Pp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4n5W-0006XW-7g
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:04:47 -0400
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c562db63-e5ec-3873-923f-b90f0c027b6c@redhat.com>
Date: Wed, 18 Oct 2017 14:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/42] MAINTAINERS: add an entry for the
 i82374 (southbridge)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 18:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f56c1349b..331f7391c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -713,6 +713,7 @@ F: hw/ppc/prep_systemio.c
>  F: hw/ppc/rs6000_mc.c
>  F: hw/pci-host/prep.[hc]
>  F: hw/isa/pc87312.[hc]
> +F: hw/dma/i82374.c
>  F: pc-bios/ppc_rom.bin
> =20
>  sPAPR
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
