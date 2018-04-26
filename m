Received: from eggs.gnu.org ([2001:4830:134:3::10]:38986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fBgEd-0004MG-4w
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fBgEc-0005G2-GN
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:42:51 -0400
Date: Thu, 26 Apr 2018 14:42:31 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180426144231.64bbfd4b.olaf@aepfle.de>
In-Reply-To: <b976e072-78c5-e12a-ba72-2075b8b635e3@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
	<20180426140807.4a4a577b.olaf@aepfle.de>
	<20180426121002.GG26812@redhat.com>
	<20180426141140.7d7b39d0.olaf@aepfle.de>
	<b976e072-78c5-e12a-ba72-2075b8b635e3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ywkq.VKJ+0B3SUTOAr/eK__";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

--Sig_/ywkq.VKJ+0B3SUTOAr/eK__
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 26 Apr 2018 14:39:04 +0200
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> On 26/04/2018 14:11, Olaf Hering wrote:
> > I suggest to revisit that testcase. =20
> That's because Red Hat backported g_realloc_n into RHEL6 :)

So the testcase does not test what it is supposed to test.
Time for a SLE11 docker image.


Olaf

--Sig_/ywkq.VKJ+0B3SUTOAr/eK__
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWuHJNwAKCRBdQqD6ppg2
fr+yAJ4z303HkyDRhu47kACNEkWdS3MQAACg8ymdlelJ0ZiNrW2KTMPKlGat3Fg=
=X4Yr
-----END PGP SIGNATURE-----

--Sig_/ywkq.VKJ+0B3SUTOAr/eK__--
