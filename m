Received: from eggs.gnu.org ([2001:4830:134:3::10]:41285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRBOo-0003Ls-SM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRBOk-0002R4-UP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:33:42 -0500
Date: Mon, 26 Nov 2018 08:33:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126073331.ankv2nyifmnuagra@sirius.home.kraxel.org>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-18-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181125205000.10324-18-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 17/25] MAINTAINERS: Add a missing
 entry to SPICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Sun, Nov 25, 2018 at 09:49:52PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2795135a09..28e5038c73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1736,6 +1736,7 @@ F: ui/spice-*.c
>  F: audio/spiceaudio.c
>  F: hw/display/qxl*
>  F: qapi/ui.json
> +F: docs/spice-port-fqdn.txt

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
