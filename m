Received: from eggs.gnu.org ([209.51.188.92]:34804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJGp-0002Jj-IM
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJGl-0002fL-JM
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:49:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1guJGf-0002bA-HE
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:49:46 -0500
References: <20190213234907.24173-1-jsnow@redhat.com>
	<11812548-716e-cc60-e6fc-20e6a2400634@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe1b880d-7b8f-fde0-afbb-a1273328645d@redhat.com>
Date: Thu, 14 Feb 2019 09:49:31 -0600
MIME-Version: 1.0
In-Reply-To: <11812548-716e-cc60-e6fc-20e6a2400634@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N0x0rmvYtVWeQiuPXbrW90KUEjl8zu0zJ"
Subject: Re: [Qemu-devel] [PULL 0/3] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N0x0rmvYtVWeQiuPXbrW90KUEjl8zu0zJ
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <fe1b880d-7b8f-fde0-afbb-a1273328645d@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] Bitmaps patches
References: <20190213234907.24173-1-jsnow@redhat.com>
 <11812548-716e-cc60-e6fc-20e6a2400634@redhat.com>
In-Reply-To: <11812548-716e-cc60-e6fc-20e6a2400634@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 5:50 PM, John Snow wrote:
>=20
> On 2/13/19 6:49 PM, John Snow wrote:
>> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd4=
3bc06:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reque=
st' into staging (2019-02-12 10:53:37 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>>
>> for you to fetch changes up to fbe8c2e3b041c682d3d52030b53e1627f285a84=
b:
>>
>>   blockdev: acquire aio_context for bitmap add/remove (2019-02-13 18:4=
2:46 -0500)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>=20
> P.S. I have extended the expiry on my GPG key and extended the expiry t=
o
> 2021, you may need to refresh keys.
>=20
> (Hopefully I did it right. This does not come up often.)

Expiration on the key shows as 2021 on my end after a re-fetch of key
0x88A9064D183561EB, so that part looks right. But we'll need a v2 pull
request, due to the fact that this one fails compilation on all
platforms. :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--N0x0rmvYtVWeQiuPXbrW90KUEjl8zu0zJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxljgsACgkQp6FrSiUn
Q2p5fwf/fL2pT4DXeknZaHoUMesGShIVgsv14Nl6Mv6CU+r6cZpFYcgyXGvpAR4I
UK+oURfHwZ1SOJfy5Ln/rFUMa2+D88oTa5VsqeiETSBxXZS6NEU1Tty6N5ggUfLi
WO2NapJqb1N33uAM4I6S75VZ1yWYySHmIJzmx0JslejZUuQblYlHG1j3SlkV88R3
KDsprnYegbi/5Amce7zrjSI+GAsI8/hj8lOBFYCeFVYQ5lPDlvR0T90RrlGBIyM1
1Jo04ClyYE3LywFDbiFcI7G+miN/weL7pP4vrXQqs+fEarVlVVfCYqWh1cJikQuy
l3pyEUuINA4YCp1slkvkXF32gO6O/A==
=+U+A
-----END PGP SIGNATURE-----

--N0x0rmvYtVWeQiuPXbrW90KUEjl8zu0zJ--
