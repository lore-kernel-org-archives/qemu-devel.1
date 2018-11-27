Received: from eggs.gnu.org ([2001:4830:134:3::10]:44750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXfD-0004vj-Bw
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXf8-0007Ku-GV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:20:07 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-22-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <be7bb28c-ee4b-d41d-10a2-dd5d272d8f94@redhat.com>
Date: Tue, 27 Nov 2018 08:19:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-22-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 21/25] MAINTAINERS: Add a missing
 entry for the NVDIMM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2018-11-25 21:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26727c1561..92691589b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1475,6 +1475,7 @@ S: Maintained
>  F: hw/acpi/nvdimm.c
>  F: hw/mem/nvdimm.c
>  F: include/hw/mem/nvdimm.h
> +F: docs/nvdimm.txt
> =20
>  e1000x
>  M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
