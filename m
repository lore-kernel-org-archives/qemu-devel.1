Received: from eggs.gnu.org ([2001:4830:134:3::10]:44118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXcD-0003We-3S
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXc8-0005aR-8B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:17:01 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-15-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c93084ba-42a0-14d1-7835-cec72eacc6f0@redhat.com>
Date: Tue, 27 Nov 2018 08:16:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 14/25] MAINTAINERS: Add missing
 entries to the vhost section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2018-11-25 21:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e124792557..eab0fb9742 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1359,6 +1359,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported
>  F: hw/*/*vhost*
>  F: docs/interop/vhost-user.txt
> +F: contrib/vhost-user-*/
> =20
>  virtio
>  M: Michael S. Tsirkin <mst@redhat.com>
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
