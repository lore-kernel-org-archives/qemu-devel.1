Received: from eggs.gnu.org ([209.51.188.92]:42388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkQuY-0002cA-Ha
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkQuX-0004Vc-Rm
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:58:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gkQuX-0004TV-L7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:58:01 -0500
Received: by mail-wr1-x42d.google.com with SMTP id q18so14242717wrx.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 01:58:01 -0800 (PST)
Date: Fri, 18 Jan 2019 09:57:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190118095758.GB21579@stefanha-x1.localdomain>
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<CAJSP0QXAz3W=qi96EL6vCn187j0QUtjGLKwVk5wWTST40h+JMg@mail.gmail.com>
	<CAObpvQkbk4j+zOz4VDeKwRc8=UqRw3aK4=0yWabS0gvBTDzBwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <CAObpvQkbk4j+zOz4VDeKwRc8=UqRw3aK4=0yWabS0gvBTDzBwA@mail.gmail.com>
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 17, 2019 at 03:57:08PM +0200, Nick Renieris wrote:
> Just a heads up, I don't know if I want to go for this myself yet.
> I'm still not sure I'll even be able to deliver the refactoring in
> time (Step 2 in your list), and I hadn't even considered tests for SSE
> as something I'd have to do since they're already implemented.
> In addition, there's been talks with a different project that I might apply for.
> I'll keep in touch if that changes, of course.

No worries.  It's still an interesting project idea and if Richard wants
to mentor it then maybe we can find an intern to work on it this summer.
You're always welcome to apply to QEMU projects!

Stefan

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQaMmAAoJEJykq7OBq3PI9d8IAJT/qJSG2ttkYvBXpmEZ52d8
jqXH6o2VFRugu8ZnGrxlNSsIqmQL55qzuu103dVUMyuqqXuUzr1gFwkmEFIcDDxG
S5dC6dSvH1NoaC1iH6SsQRxx2ge6aILZD3T7oqZ+hq/pTVDuLQEp8SwT1mAFTxuT
jgmcMlzPr1s4CYGBlARArs4afW2ZN5nbPikntibWVKx0xKOSx5YRf+czreZcgUNy
lY1Wk2FerNTADTqlJtWZhMmuVHf4UskqsDPvHZ2SfMfOsF4EzWJXcJPEdQxL8Gdr
1QGRSQw+iT25zy1295DdOTzXGKhIETxcdpyTRr1WXRlEQxvzm588imaqax6O4MQ=
=n6p3
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
