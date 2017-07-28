Received: from eggs.gnu.org ([2001:4830:134:3::10]:37823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazKw-0006e8-Do
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazKt-0002Pp-0u
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:05:26 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-9-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e35426ff-9c8b-1e04-bc53-e6302deee776@redhat.com>
Date: Fri, 28 Jul 2017 09:05:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/47] MAINTAINERS: add missing entry for
 virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 69987b5e5b..6da3264d4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1046,6 +1046,7 @@ F: hw/virtio/Makefile.objs
>  F: hw/virtio/trace-events
>  F: net/vhost-user.c
>  F: include/hw/virtio/
> +F: include/standard-headers/linux/virtio_*

Same as for the linux-headers folder: include/standard-headers comes
from the Linux kernel ... not sure whether it makes sense to add an
entry in our MAINTAINERS file here...

 Thomas
