Received: from eggs.gnu.org ([2001:4830:134:3::10]:54265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaBf-00068t-18
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaB7-0008SZ-Jd
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:59:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egaB7-0008RG-7e
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:58:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 467B728225
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:58:40 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9d7fd2d-6de5-8070-428e-31305d2a357a@redhat.com>
Date: Tue, 30 Jan 2018 11:58:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-15-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Yx3kBqNWyWSStY3sMfXq3vppnOhTZU89"
Subject: Re: [Qemu-devel] [PATCH 14/18] Include qapi/qmp/qnum.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Yx3kBqNWyWSStY3sMfXq3vppnOhTZU89
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b9d7fd2d-6de5-8070-428e-31305d2a357a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/18] Include qapi/qmp/qnum.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-15-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qlit.c | 1 -
>  1 file changed, 1 deletion(-)

Not much to this one :)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2Yx3kBqNWyWSStY3sMfXq3vppnOhTZU89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwsk8ACgkQp6FrSiUn
Q2qFaggAor0bc0FToLauqL8pqr2zp9CQ1NP0yedQPgFfrC/bt2G/80Xyg22lJMpZ
qDmzJGhgUfaXHAG/2LiiEamMI39fb3jPUhHMW2BEuuzo6Rsb6wuS10K5CyM5cTAc
nIwCnS96sON6nJlloGYzbmlpyjBTFjWwILvkQgg/YNmYHUqqMvpOAJGj8j7Q1wcS
lyja2Im/dp/IhQhIMO4u99NeY6BlNyltcSxGuSy6t4AfpstG/8OJ6F7BDCDc3LD1
TzQsRmOwwEMmRf8TvcZaxVoO8hFLrf9d4dndzjLr3ni8Ct+XqkXPwdSRW186JUsE
LzVGcsabewmdUSLzcrSQmtPt/L/bQw==
=YeHL
-----END PGP SIGNATURE-----

--2Yx3kBqNWyWSStY3sMfXq3vppnOhTZU89--
