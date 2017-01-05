Received: from eggs.gnu.org ([2001:4830:134:3::10]:36415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPGj4-0006TG-5M
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPGiz-00054r-C8
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:41:38 -0500
Received: from ignoranthack.me ([199.102.79.106]:65299
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cPGiz-00054i-6g
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:41:33 -0500
Received: from [172.17.53.170] (50-243-21-81-static.hfc.comcastbusiness.net
	[50.243.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbruno@ignoranthack.me)
	by mail.ignoranthack.me (Postfix) with ESMTPSA id 960751928BA
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 22:41:29 +0000 (UTC)
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
Date: Thu, 5 Jan 2017 15:41:24 -0700
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="rOSA65RNH1sTv9hpRjs0KactGbu8bDI4t"
Subject: [Qemu-devel] [scripts] default shell/perl locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rOSA65RNH1sTv9hpRjs0KactGbu8bDI4t
From: Sean Bruno <sbruno@freebsd.org>
To: qemu-devel@nongnu.org
Message-ID: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
Subject: [scripts] default shell/perl locations
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I don't suppose it would be possible to have configure check/change the
interpreter path for scripts so that operating systems that don't have
/usr/bin/perl for example, would work out of the box?

sean


--rOSA65RNH1sTv9hpRjs0KactGbu8bDI4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhuy5VfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmS9MAf+J9B7mlUaFmEwCmLTmyQee4IVxYl3N4orjVt7AW9gN8amTXvSGzENZAK4
uVbkc7t7hEyBDnklIrvPSMhtYVD7KRUVdo2UUUO0KvmFvEpoTucebebYdqSoHp0J
OS3QxfoUOpHsk6oTIMUH4qAqgbeeTLydokkVnFhl6AvQ1V8aA2RqpiPJtyCewKke
aXCRXuLtgmTcqMYIcdm3Pjgedu/2AiZKl9t/+HE7O19gvp/gzLw038FyHdS5SqfI
0hvZrZeZKN1UAYuwQD/b41dqytc9+JDjBmtWAhFlLkukNR67G8qNrnYfCG9vYXzX
A4xw0ITal9O/QUznwPHEDBUuG9lbVg==
=+RBB
-----END PGP SIGNATURE-----

--rOSA65RNH1sTv9hpRjs0KactGbu8bDI4t--
