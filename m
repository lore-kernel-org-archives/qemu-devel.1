Received: from eggs.gnu.org ([2001:4830:134:3::10]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGw3-00071H-D8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGvy-0000Gm-AK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:05:27 -0500
Date: Tue, 18 Dec 2018 07:39:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218073945-mutt-send-email-mst@kernel.org>
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218115615.1499-4-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/12] MAINTAINERS: Add missing entries
 for the PC machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Tue, Dec 18, 2018 at 12:56:06PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dac394d125..f3305a65b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1141,6 +1141,10 @@ F: hw/acpi/ich9.c
>  F: include/hw/acpi/ich9.h
>  F: include/hw/acpi/piix4.h
>  F: hw/misc/sga.c
> +F: hw/isa/apm.c
> +F: include/hw/isa/apm.h
> +F: tests/test-x86-cpuid.c
> +F: tests/test-x86-cpuid-compat.c
> =20
>  PC Chipset
>  M: Michael S. Tsirkin <mst@redhat.com>
> --=20
> 2.17.2
