Received: from eggs.gnu.org ([2001:4830:134:3::10]:45078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRKc-0005HZ-GP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRKZ-0008Tz-Cd
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:27:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eCRKZ-0008TF-3U
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:27:51 -0500
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
	<1510049762-4609-3-git-send-email-peter.maydell@linaro.org>
	<CD2DCF39-4633-4F81-8B5E-75B49DB93D12@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5909acc5-056c-3f37-f683-e826f98a287f@redhat.com>
Date: Wed, 8 Nov 2017 08:27:49 -0600
MIME-Version: 1.0
In-Reply-To: <CD2DCF39-4633-4F81-8B5E-75B49DB93D12@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w6cocsIEMSxdpKPAp7W6ktmMW3uDCkSap"
Subject: Re: [Qemu-devel] [PULL 2/3] ui/cocoa.m: move ungrab to ctrl-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w6cocsIEMSxdpKPAp7W6ktmMW3uDCkSap
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Message-ID: <5909acc5-056c-3f37-f683-e826f98a287f@redhat.com>
Subject: Re: [Qemu-devel] [PULL 2/3] ui/cocoa.m: move ungrab to ctrl-alt-g
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
 <1510049762-4609-3-git-send-email-peter.maydell@linaro.org>
 <CD2DCF39-4633-4F81-8B5E-75B49DB93D12@gmail.com>
In-Reply-To: <CD2DCF39-4633-4F81-8B5E-75B49DB93D12@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 06:04 AM, Programmingkid wrote:
>=20
>> On Nov 7, 2017, at 5:16 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>
>> From: John Arbuckle <programmingkidx@gmail.com>
>>
>> Currently the cocoa user interface relis on the user pushing
>=20
> I would change "relis" to "relies" here.

Too late; it's already commit 5929e36c

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w6cocsIEMSxdpKPAp7W6ktmMW3uDCkSap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDFGUACgkQp6FrSiUn
Q2rj7gf/THI9a4UDi9xcs7MwzFtXLdwwUempW6shWs5MQFwxCriCjkoUhbAwlXoA
vOEzoI8JGIrEcSibqBMNwZH6a3N/u0zTlZ/it/mdaBmpiOCY3ZsKuWNjZqADurGV
u7MMbq+v2WiJ3zAsvxx0jBgp5K6vII2Rm4/b1mPpkdvEPNm3Jn+R7nf7q/1Dk7Mu
r/HLnxNGFshr1r1icXyUQRjoH1ti3n4PrqfeHT0yskMAHj1HMGj1VQPM1eRdOyeB
ox6VNI3qWYBKzAoFThU533aFfJaUujgy+1mxGWOIXxpZm9KsK7OFoJjVT2wzxUK2
JFAYIkG5k3+n7paaE/LRkN9IHx/1hA==
=KTTz
-----END PGP SIGNATURE-----

--w6cocsIEMSxdpKPAp7W6ktmMW3uDCkSap--
