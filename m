Received: from eggs.gnu.org ([2001:4830:134:3::10]:60314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5XLm-00021k-Uu
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5XLj-0003IY-RT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:28:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5XLj-0003Gu-Hk
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46024127AD
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 13:28:30 +0000 (UTC)
References: <20171020070914.7785-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4372d330-0dbc-4e8d-a976-9db71b76f1d5@redhat.com>
Date: Fri, 20 Oct 2017 08:28:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171020070914.7785-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5d2PNPoqoafHGEk1P6tjF708OVTRw8pJv"
Subject: Re: [Qemu-devel] [PATCH] ui: add qemu-keymap and shader to
 .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5d2PNPoqoafHGEk1P6tjF708OVTRw8pJv
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4372d330-0dbc-4e8d-a976-9db71b76f1d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: add qemu-keymap and shader to .gitignore
References: <20171020070914.7785-1-kraxel@redhat.com>
In-Reply-To: <20171020070914.7785-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 02:09 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/.gitignore b/.gitignore
> index 620eec6b47..588769b250 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -14,6 +14,7 @@
>  /trace/generated-tcg-tracers.h
>  /ui/shader/texture-blit-frag.h
>  /ui/shader/texture-blit-vert.h
> +/ui/shader/texture-blit-flip-vert.h
>  /ui/input-keymap-*.c
>  *-timestamp
>  /*-softmmu
> @@ -45,6 +46,7 @@
>  /qemu-io
>  /qemu-ga
>  /qemu-bridge-helper
> +/qemu-keymap
>  /qemu-monitor.texi
>  /qemu-monitor-info.texi
>  /qemu-version.h
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5d2PNPoqoafHGEk1P6tjF708OVTRw8pJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnp+foACgkQp6FrSiUn
Q2qq1Qf/TXPspfm2UAz9Z1AQEE4lG7A6lAfAeFIWMZUMgJbei8mO3VCIBzRuLoOH
OTIMfFkwUPN9tKhNbI9lEUf9C8Eagbj0wUerV9FVQ+HE6+Grweiexwa8VfcsA4Sk
gHymyri1WXLY/GSjRCOTmA+Krqq2qSm6XwgaN7FsOoRpyvZOED+9aFbn2D2ibO6/
sTU8J8Ndsdtj4wsEt7pm+ON6USkXFCpXZxFlImqMOWkZCAExFtU16VXnqt/kNQzk
FSX5D6fNuX79MEAPTAR4/eBW3IeuoVu8UfKh/2AiokFRA+L85eP5VKAOhiWFdznO
+sFeEmG5+DgbeJMiCUJUmSX+AGbt9w==
=j9rx
-----END PGP SIGNATURE-----

--5d2PNPoqoafHGEk1P6tjF708OVTRw8pJv--
