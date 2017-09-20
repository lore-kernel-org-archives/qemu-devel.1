Received: from eggs.gnu.org ([2001:4830:134:3::10]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dueoY-0000Pv-5m
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dueoU-0007vb-6Q
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dueoT-0007v0-Tn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:14 -0400
References: <20170920032555.18911-1-famz@redhat.com>
	<20170920032555.18911-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9e18b6d-bc10-8621-4d79-6f84d309c8a6@redhat.com>
Date: Wed, 20 Sep 2017 08:13:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170920032555.18911-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mAguDAHMWoGiho0rdhn0GJTccnWtW3Pbk"
Subject: Re: [Qemu-devel] [PATCH v10 01/13] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mAguDAHMWoGiho0rdhn0GJTccnWtW3Pbk
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <c9e18b6d-bc10-8621-4d79-6f84d309c8a6@redhat.com>
Subject: Re: [PATCH v10 01/13] gitignore: Ignore vm test images
References: <20170920032555.18911-1-famz@redhat.com>
 <20170920032555.18911-2-famz@redhat.com>
In-Reply-To: <20170920032555.18911-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:25 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitignore       | 1 +
>  tests/.gitignore | 1 +
>  2 files changed, 2 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mAguDAHMWoGiho0rdhn0GJTccnWtW3Pbk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCaWEACgkQp6FrSiUn
Q2rh5Qf/WMl896rX79TNYhd4hUpOwt6/a4ZC4MBju6KgE6tzPTFAgtM6KyDNJDof
omHphQ6kNH6JLocCV2a/+ZUzd0lxCh6rHZW+rKpdpfXIO0AWop+q5GqUqZhGH+Rt
zO9kTjxSuEvqFr+QliET5z7+CLRI1N0iK9NMqc+hjydkoJtKt16slyboePZu1M3d
ASJ8l1/yGteT5+eoDx5hh8Kn+RmFBDYV+Eo89EYI9AuZIRght4PflvLmRgyG6NTK
i5Geas9gQnUHWgbigFvqy7xVYIq7QqR5vUjMsgunn579Qnaly00Vtnk70Gxy7hok
g3reiFtKa4ntnd/rTY5EpJrLwulXAA==
=kail
-----END PGP SIGNATURE-----

--mAguDAHMWoGiho0rdhn0GJTccnWtW3Pbk--
