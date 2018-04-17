Received: from eggs.gnu.org ([2001:4830:134:3::10]:60334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Xf1-0001Q6-R8
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Xex-0002J2-VJ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:57:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8Xex-0002BH-LJ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:57:03 -0400
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24508722-fcc7-f795-061c-638c9aa1a0ce@redhat.com>
Date: Tue, 17 Apr 2018 15:56:58 -0500
MIME-Version: 1.0
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BShazHN5GXz0guUtLtKGuowQvJZKX57X0"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] cpus: correct coding style in
 qmp_memsave/qmp_pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BShazHN5GXz0guUtLtKGuowQvJZKX57X0
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Message-ID: <24508722-fcc7-f795-061c-638c9aa1a0ce@redhat.com>
Subject: Re: [PATCH v2 1/5] cpus: correct coding style in
 qmp_memsave/qmp_pmemsave
References: <20180412124834.GA2025@ruderich.org>
 <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 07:50 AM, Simon Ruderich wrote:
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  cpus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

However, as a meta-comment, this message was sent with:

> Message-Id: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.si=
mon@ruderich.org>
> In-Reply-To: <20180412124834.GA2025@ruderich.org>
> References: <20180412124834.GA2025@ruderich.org>

Looking on patchew, I see:
http://patchew.org/QEMU/20180412124834.GA2025@ruderich.org/
The requested URL /QEMU/20180412124834.GA2025@ruderich.org/ was not
found on this server.

For most messages, looking up the In-Reply-To: message-id gives the
cover letter (for example,
http://patchew.org/QEMU/20180412115838.10208-1-alex.bennee@linaro.org/)

Similarly, looking on the list archives, I don't see the 0/5 cover
letter, but rather that your messages are treated as threaded to your v1
thread:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/threads.html#01388

For the sake of tooling, it's best to send a v2 series with a new cover
letter as a new top-level thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BShazHN5GXz0guUtLtKGuowQvJZKX57X0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWX5sACgkQp6FrSiUn
Q2rjJQf+ICm1J1AA14M3GrhiYaYMJIyJlfpjCRCV4rlhIGshufcRJUNNk0E5/yTw
ydO6xjnsSht9Wngp/UAy80w9VdIumoTkJEk9Cd3Erq3dp3tFYqGZDYiRR6PjcLx8
9QVE+zpgKvUJEt9JkPIn8hQnH0GF0hhPtPkiP0h8Qh2QAkgvLWZf5dadU35xgtfe
+qZZ7mTAgvJ4TBKBRFBa97rY5hokC3ppVdiCwyqhXP3EiFMQ8TbsaeSNr3zcsDmS
+jAH94aHEj1eP7Ros4vsqVB9/U4CUtaIq4PD0h8cEaNUkClCKnKxsm7rWpWwfOb8
SPmLkZZnOuhZ06BBXStbt/LYVA6eWQ==
=c+YY
-----END PGP SIGNATURE-----

--BShazHN5GXz0guUtLtKGuowQvJZKX57X0--
