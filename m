Received: from eggs.gnu.org ([2001:4830:134:3::10]:39902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWgl-0003NY-HP
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWgh-0000tw-Eg
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:47:31 -0500
References: <20171116194902.5887-1-sw@weilnetz.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <52eaa698-87e1-e40a-5bf1-db4b62412838@redhat.com>
Date: Fri, 17 Nov 2017 10:47:21 +0800
MIME-Version: 1.0
In-Reply-To: <20171116194902.5887-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] MAINTAINERS: Add missing entry
 for eepro100 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B411=E6=9C=8817=E6=97=A5 03:49, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffd77b461c..83434e09af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1183,6 +1183,11 @@ M: Dmitry Fleytman <dmitry@daynix.com>
>   S: Maintained
>   F: hw/net/e1000e*
>  =20
> +eepro100
> +M: Stefan Weil <sw@weilnetz.de>
> +S: Maintained
> +F: hw/net/eepro100.c
> +
>   Generic Loader
>   M: Alistair Francis <alistair.francis@xilinx.com>
>   S: Maintained

Applied.

Thanks
