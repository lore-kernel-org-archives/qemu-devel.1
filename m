Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gICIQ-0004jN-HD
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gICIL-0008Un-FG
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:41:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gICIL-0008Tz-5w
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:41:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id b203-v6so1219035wme.5
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 05:41:53 -0700 (PDT)
Date: Thu, 1 Nov 2018 12:41:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101124150.GS24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-11-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mln0rGgUGuXEqmuI"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-11-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 10/13] tests/microbit-test: Add Tests
 for nRF51 GPIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--mln0rGgUGuXEqmuI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:24PM -0400, Steffen G=F6rtz wrote:
> The test suite for the nRF51 GPIO peripheral for now
> only tests initial state. Additionally a set of
> tests testing an implementation detail of the model
> are included.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  tests/microbit-test.c | 122 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mln0rGgUGuXEqmuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vSOAAoJEJykq7OBq3PIaYAIAKVg7H3+Vp8FRZ1NkLqHLV0P
//nGptAGiu0Bt8aTgXa+6YukRf59VL1P3gCHf6U4aXqmqJwRVSfA7YW/RrBCuhBm
QXfGC4S5+aYRFsp7Djf/Zm4sEri765bGWFdJEVXXU13VbvFnlWkNkYqjPKdyF/Jc
oSxA2/DZh/pD33BpHb5bCJPj0BpvaImTGfrwgF0fpHobdqQBAkAHQ9Z3GfyW5YRF
b58Z9I0fFjHfdMM0Bfuz8XCINz+Y2oJHAOAXHdOWeS3eE3gx5fayEFwLymN9MDge
YhKpk6MqDAZSUhtxyTmgspLdoV9rI7L+Nyf0D6nOlJ8HoV3bUQrbBAU5Rf2edCM=
=PBS+
-----END PGP SIGNATURE-----

--mln0rGgUGuXEqmuI--
