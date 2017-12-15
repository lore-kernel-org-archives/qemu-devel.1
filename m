Received: from eggs.gnu.org ([2001:4830:134:3::10]:59232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePn4A-0001sg-Tn
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePn46-0008Cp-Vh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:18:06 -0500
References: <20171215033015.738-1-f4bug@amsat.org>
	<20171215033015.738-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <800d15c5-fe10-56af-083c-501291d245ad@redhat.com>
Date: Fri, 15 Dec 2017 11:17:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171215033015.738-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 04/43] MAINTAINERS: add an entry for the
 i82378 (superio)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

On 15.12.2017 04:29, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Remove the doubled Reviewed-by, or replace the second line with:

Reviewed-by: Thomas Huth <thuth@redhat.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 31c673d60a..4618f9b4db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -732,6 +732,7 @@ F: hw/ppc/prep.c
>  F: hw/ppc/prep_systemio.c
>  F: hw/ppc/rs6000_mc.c
>  F: hw/pci-host/prep.[hc]
> +F: hw/isa/i82378.c
>  F: hw/isa/pc87312.[hc]
>  F: hw/dma/i82374.c
>  F: pc-bios/ppc_rom.bin
>=20
