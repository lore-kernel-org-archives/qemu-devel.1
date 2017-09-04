Received: from eggs.gnu.org ([2001:4830:134:3::10]:58242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1doo3G-00063X-8b
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1doo38-00049i-Ih
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:52:18 -0400
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-10-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e99108db-bf6a-b0de-696d-102634cc1066@redhat.com>
Date: Mon, 4 Sep 2017 12:51:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170830215523.25278-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/17] MAINTAINERS: add missing PCI
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 31/08/2017 0:55, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5e2c2b6b..bbe1191883 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -928,6 +928,8 @@ F: include/hw/pci/*
>   F: hw/misc/pci-testdev.c
>   F: hw/pci/*
>   F: hw/pci-bridge/*
> +F: docs/pci*
> +F: docs/specs/*pci*
>  =20
>   ACPI/SMBIOS
>   M: Michael S. Tsirkin <mst@redhat.com>
>=20

  Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
