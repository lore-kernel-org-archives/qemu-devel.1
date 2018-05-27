Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fMrxY-0008C0-J1
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fMrxT-0001E5-MM
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:27:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fMrxT-0001DR-I6
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D443805A52F
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 09:27:23 +0000 (UTC)
Date: Sun, 27 May 2018 11:27:02 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180527092702.GE22274@dnr>
References: <20180525153609.13187-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20180525153609.13187-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: print virglrenderer version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 05:36:09PM +0200, Marc-Andr=E9 Lureau wrote:
>Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>---
> configure | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlsKeeAACgkQyvpdPXT/
Aml+BxAA0rjfGLS7k0BNvVNvRkXBdINrRTf039NGRLVGTmOkaLc/lpVvSeLebps9
O+DoK5AFUUr8ZUbEoV7SCMW0+ROjFZwHLdfKpYu7Fsy0HDDwqwhucAmfP4Uihm1P
fRiE5dzgbXNwBi4yeoWWEchBJmw/imPon4VXCGStCPpFiNZ4Ph/aXHiO6FoHH2zf
YskLLLEml734tXYSc4Xf0v3s3+iILsS+/gHR6fMB+/RL+KXKoV9+wk6egQdsXm4u
xuKHQ82dVax7tUitthf7fWAonFHAwpJcX2xZK1NC4f4shH1cMK9LavSeqBw6yuGO
bl6n+6Y6Rzw5uT7xMQ4YK+WxKzoYFK3mpPew9vDL4LLQABYi33zGMZF2obqLvCb9
/qC4/oLyLgZHCggQ588yTCdhTJbUw1W60x5IUhzMhVWmWB/g4+lCSi0p/B+cQt0s
Ys5SGkZfM+DPFthR4ur5KlLxzS/VmZFsCUM+3cyMTOaokLmEqWpku8UHwNfF4TbN
BycEknaP/YHg9y6VPg/6kolqO+bcL5a3yB5kDcx8Mget8LiA7gFoO5EK9lKAr/bl
C+AFTO1q9sGxTDTxt4V/1Iy/y6iKm10LrJ3g7VZRW7bl/uiA6fv1sb4iORWx259t
sVY0Uylh5VBj7SbX7iK+Cf7+OehD40BlajYv3kRHOyHIJgE+Qcg=
=l1uZ
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
