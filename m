Received: from eggs.gnu.org ([2001:4830:134:3::10]:56070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daz3i-0003Qi-EL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daz3e-00075r-7m
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:47:38 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3be12552-daf6-450f-765e-ce390c4bf3c6@redhat.com>
Date: Fri, 28 Jul 2017 08:47:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 01/47] MAINTAINERS: add missing entry
 for documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
> because having only a "Build system architecture" entry in Documentatio=
n seems
> odd to me, so RFC.
>=20
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ea273f899..972118e70b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1886,6 +1886,9 @@ W: http://patchew.org/QEMU/
> =20
>  Documentation
>  -------------
> +Overall
> +F: docs/

But it also does not make sense to add such an entry without a "M:"
line, does it?

 Thomas
