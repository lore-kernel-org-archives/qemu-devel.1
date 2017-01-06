Received: from eggs.gnu.org ([2001:4830:134:3::10]:32935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXnb-0000sf-Is
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXnY-00086Z-Fx
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:55:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPXnY-000864-7G
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:55:24 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2ACF24E33C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:55:24 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fa2dd2d-6c7f-9704-1f99-463a421f32a6@redhat.com>
Date: Fri, 6 Jan 2017 10:55:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KlAGt1uHPWHqEJKmAbbfQrDErQIgn3shS"
Subject: Re: [Qemu-devel] [PATCH 04/20] doc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KlAGt1uHPWHqEJKmAbbfQrDErQIgn3shS
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <1fa2dd2d-6c7f-9704-1f99-463a421f32a6@redhat.com>
Subject: Re: [PATCH 04/20] doc: fix spelling
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> I am pretty sure that's the word Fabrice Bellard intended to write.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Spell-checkers don't flag everything :)

>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6ee8a8adc3..cfa25ceea0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3016,7 +3016,7 @@ udp::4555@@:4556} to QEMU. Another approach is to=
 use a patched
>  version of netcat which can listen to a TCP port and send and receive
>  characters via udp.  If you have a patched version of netcat which
>  activates telnet remote echo and single char transfer, then you can
> -use the following options to step up a netcat redirector to allow
> +use the following options to set up a netcat redirector to allow
>  telnet on port 5555 to access the QEMU port.
>  @table @code
>  @item QEMU Options:
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KlAGt1uHPWHqEJKmAbbfQrDErQIgn3shS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8v6AAoJEKeha0olJ0Nqn/cIAJuqRPEDuiPRGyXvV+VX98wo
4ek7zqZ8tNT4v1ZkGCPuzlcRzz8Oxf+YZY9drpIAwLF4iasuRc0F9CFKXdly2gtj
N+qvEDYFSkMyAhaReEWM1nqs9fqWVUCZZwACERIWN+keze6iqT3hqfQchjuBhewW
E70LQWFHZqEKToXug1oqOt2z8109HEjNW0bZAIArBsFxKSUnDL6qG8ZHKaqF2+c7
UNi+y4H8j8MVZ01JPwI1Ah35+i7zD0XejlhFyihZyZAanZkoaNB2VUzGKCbbkyBQ
mDlcYiaFV9QthAXfYCmyXNEwE1TMd4/iZfKZsgjsjaetaSNQQNpg1RN4jvNLBa4=
=6l1b
-----END PGP SIGNATURE-----

--KlAGt1uHPWHqEJKmAbbfQrDErQIgn3shS--
