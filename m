Received: from eggs.gnu.org ([2001:4830:134:3::10]:54084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRZzt-0005ky-Ry
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRZzp-0000YN-8q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:49:37 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-8-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <19bfc512-65ac-9968-3930-8b423efde241@redhat.com>
Date: Tue, 27 Nov 2018 10:49:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 07/25] MAINTAINERS: Add a missing
 entry for the Fulong 2E machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2018-11-25 21:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa17e9bbd3..81a22b2ccf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -864,6 +864,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> +F: hw/pci-host/bonito.c
> =20
>  F: include/hw/isa/vt82c686.h

Please remove the empty line between bonito.c and vt82c686.h - or we
could use my patch here from last Thursday instead:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04526.html

 Thomas
