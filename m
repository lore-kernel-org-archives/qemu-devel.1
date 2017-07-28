Received: from eggs.gnu.org ([2001:4830:134:3::10]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3wY-0005KX-Nm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db3wX-0003m3-S6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:00:34 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-17-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7100714b-6789-15e4-f883-9e8684ddc9e7@redhat.com>
Date: Fri, 28 Jul 2017 14:00:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-17-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/47] MAINTAINERS: add missing entry for
 gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 28/07/2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9670a3901a..653c2a1db1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1320,6 +1320,7 @@ L: qemu-devel@nongnu.org
>  S: Odd Fixes
>  F: gdbstub*
>  F: gdb-xml/
> +F: scripts/qemugdb/

This is unrelated.  It's for debugging QEMU, while the others are for
debugging QEMU guests.

Paolo

>  Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>
>=20
