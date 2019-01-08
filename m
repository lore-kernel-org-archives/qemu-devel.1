Received: from eggs.gnu.org ([209.51.188.92]:45688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1ggomw-0000nr-QC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1ggomu-0005hd-UM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:39:13 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1ggomu-0005YO-NK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:39:12 -0500
References: <20190108102301.1957-1-kraxel@redhat.com>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <f757d3c9-88dc-5c55-b736-ac08009ea0ac@msgid.hansmi.ch>
Date: Tue, 8 Jan 2019 11:38:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190108102301.1957-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="cNPGyMh5oxwtuVLyJmZpjQ9Hmdb5970H1"
Subject: Re: [Qemu-devel] [PATCH] i2c-ddc: fix oob read
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
--cNPGyMh5oxwtuVLyJmZpjQ9Hmdb5970H1
From: Michael Hanselmann <public@hansmi.ch>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f757d3c9-88dc-5c55-b736-ac08009ea0ac@msgid.hansmi.ch>
Subject: Re: [PATCH] i2c-ddc: fix oob read
References: <20190108102301.1957-1-kraxel@redhat.com>
In-Reply-To: <20190108102301.1957-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.01.19 11:23, Gerd Hoffmann wrote:
> Suggested-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Looks good to me.

Reviewed-by: Michael Hanselmann <public@hansmi.ch>


--cNPGyMh5oxwtuVLyJmZpjQ9Hmdb5970H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENEVC6w7lpobWh8t0Yy8zJpbbY3YFAlw0fccACgkQYy8zJpbb
Y3Z9Ig/9GqhKMwoJchIqiAwkax9YWjg8MByQvggsBz/NLGKBJMapn1RyXLLINxlW
u/m0X/SsarR2u+TvlAsaItOaAudyar6wQhu1l5OTtn25COwrrJg5oP57oyiDJTMj
xW84Y2FJLRUqzt7BFF8V+dPUri/RCYvDijwkG/BaG9dfB8v1GK3K/3uPVyU0J2vc
zOPjmM7rD49LCVf0hwllMvjw6fqmZro67KSZhVGebc5e4XWIF9nZDt218vqqIbS6
NOm0QFuzrGB3t4KJES+ljqYpBaChw4K5Qor+GH+xCgbKaVIXQCl0fGfqH9+bOFpu
7dWYqByoyGHv/lKn47V4Wd4qNWddjQz9PG6nbiH5TH2CQveHfkEsl89BGyNsefZ8
j6H1iUyxsGIKZFoZZHZ8gqykduZ62y1qrDbQixfm5XoO5kELUdKnu2UqM1odSA9R
QKjpuDAr+7k41WE7bWoH9AWP43wKZShpZgKslojjglXaK2wFGWSQX5GVTOI41JPz
qxZmWqcKZOzle/6sy6Zm9bBU9x1AdVWpb6rvP0WAOxHM65dWJ1nH+QzQw8IJ8Ngc
UHCc66a3EpXIdxXoS699QuKQXum5qc3FIGvGQJHd0Cxb01XT6Yrdo0oGgnG5m7Iz
gydp0KoxfTx2Ffrq6H7NJaXIrou4DO8gttuV7OJyB8TlzpkHGbo=
=D7pV
-----END PGP SIGNATURE-----

--cNPGyMh5oxwtuVLyJmZpjQ9Hmdb5970H1--
