Received: from eggs.gnu.org ([2001:4830:134:3::10]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXaE-0002k7-4y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXa9-0004iG-8z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:14:58 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-14-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2d60f3df-272a-2d87-4350-c274b25276dc@redhat.com>
Date: Tue, 27 Nov 2018 08:14:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-14-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 13/25] MAINTAINERS: Add missing
 entries to VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2018-11-25 21:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bfe71f2555..e124792557 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1326,6 +1326,8 @@ M: Alex Williamson <alex.williamson@redhat.com>
>  S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
> +F: include/qemu/vfio-helpers.h
> +F: docs/igd-assign.txt

Sounds reasonable to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
