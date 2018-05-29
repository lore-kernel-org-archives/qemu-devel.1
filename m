Received: from eggs.gnu.org ([2001:4830:134:3::10]:45694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNcmo-00031S-2k
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNcmj-0003CJ-6b
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:27:30 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-19-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b209771-baf4-fdbb-082f-8dbb979eae9e@redhat.com>
Date: Tue, 29 May 2018 13:27:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-19-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 18/21] hw/hppa: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29.05.2018 01:27, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/hppa/hppa_sys.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
> index a182d1f34e..3f6c145120 100644
> --- a/hw/hppa/hppa_sys.h
> +++ b/hw/hppa/hppa_sys.h
> @@ -3,7 +3,6 @@
>  #ifndef HW_HPPA_SYS_H
>  #define HW_HPPA_SYS_H
> =20
> -#include "target/hppa/cpu-qom.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/ide.h"
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
