Received: from eggs.gnu.org ([2001:4830:134:3::10]:37252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1cHBfD-0005pw-8U
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1cHBf9-0004zd-Cj
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:40:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ptoscano@redhat.com>) id 1cHBf9-0004yY-7p
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:40:11 -0500
From: Pino Toscano <ptoscano@redhat.com>
Date: Wed, 14 Dec 2016 16:40:01 +0100
Message-ID: <1619747.imectsegtr@thyrus.usersys.redhat.com>
In-Reply-To: <20161214144713.11009-1-stefanha@redhat.com>
References: <20161214144713.11009-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10990183.turv4c1H40";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.8] po: add missing translations in de, fr, it,
 zh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

--nextPart10990183.turv4c1H40
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 14 December 2016 14:47:13 CET Stefan Hajnoczi wrote:
> There are missing translations for the new "Copy" menu item.
> 
> The following people provided them to me on IRC just in time for the
> QEMU 2.8 release:
> 
>  * de_DE - Stefan Hajnoczi <stefanha@redhat.com>
>  * fr_FR - Laurent Vivier <laurent@vivier.eu>
>  * it    - Pino Toscano <ptoscano@redhat.com>
>  * zh_CN - Fam Zheng <famz@redhat.com>
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Pino Toscano <ptoscano@redhat.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> [...]
> diff --git a/po/it.po b/po/it.po
> index 8eadf2f..bfae84e 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -42,11 +42,11 @@ msgstr "_Esci"
>  
>  #: ui/gtk.c:2029
>  msgid "_Fullscreen"
> -msgstr ""
> +msgstr "A t_utto schermo"
>  
>  #: ui/gtk.c:2032
>  msgid "_Copy"
> -msgstr ""
> +msgstr "_Copia"
>  
>  #: ui/gtk.c:2048
>  msgid "Zoom _In"

ACK.

Should PO-Revision-Date be updated as well?

Thanks,
-- 
Pino Toscano
--nextPart10990183.turv4c1H40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJYUWfRAAoJEMPRTC2YZDfN57QQAIhRCqGJ+gSsV0mt1ODmb8O2
dUo7lOqe8PU+AtE/tNxTmh2IW9HrR2WR651x4bAHo4Qp3vVh0mwwodG9b4k+pJXv
1m3glaHGgzwuCwUWnIkqERfjtBPgNkf+xtwUTZUrScaGnN6EWOFFbRW6zOOV6RFl
d1s2b3B0kjXgGO4h2MG+AFheeQ1+t98SS5WQE0x4Mg3gGLqCADyEubHbQ116Vo0D
/F8iraHKFAOWdouUTAphuCSqqWJNDBsEME+b31upJBQRz7L3gZdjOQ75/3o1ay2O
rJS8XS5OYtFjHIr92RSVZAOPiSy36QifBlnds0F8NR5Ehzm9Xg/s+3Fs62Lox/Xc
lZaTfSTolvoIsOkr/LwlcqitB37Py537ZGuvPAjlSUPXVzKd1e10ZoEdRUzuWj7C
maHtqyV/rAcq9bGELB8IZyNdTHrWrA+5fKLDOfNIRk1i0YoRJlk25Se9q/ZWN9on
RgXgNlEUuQvsP9VX32tqZed35WjwE69ABEHsSa/DTOUWMthzEFHarqOPBfKcAk2e
VLJ2M76+bvATrBKgUGffpOssSsafvDiaZJ4n4KHqtzY1cN0MSsdMSeUJdk2JMDrJ
b101X5CYawiOOCuHwg6N+rZtLpBMoqWPhpUOBvNNUFdUUA/k7geXByaMw/GujcLJ
GuLu8iL0v0PLQ4DxwrTw
=V8CZ
-----END PGP SIGNATURE-----

--nextPart10990183.turv4c1H40--
