Received: from eggs.gnu.org ([2001:4830:134:3::10]:38391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dn0M0-0002wu-0o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dn0Ly-00022p-V7
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:36:12 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<20170828025706.GA18194@lemon.lan>
	<923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
	<CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1491bc75-e1ee-b63b-a75b-6d5c39faab7c@redhat.com>
Date: Wed, 30 Aug 2017 12:35:49 +0200
MIME-Version: 1.0
In-Reply-To: <CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W3StoH1sa3UioEh6ih0SFlU6Lo5NPgKHw"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Yaniv Lavi (Dary)" <ylavi@redhat.com>, John Snow <jsnow@redhat.com>, "Mureinik, Allon" <amureini@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Fam Zheng <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Tal Nisan <tnisan@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W3StoH1sa3UioEh6ih0SFlU6Lo5NPgKHw
From: Max Reitz <mreitz@redhat.com>
To: "Yaniv Lavi (Dary)" <ylavi@redhat.com>, John Snow <jsnow@redhat.com>,
 "Mureinik, Allon" <amureini@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Fam Zheng <famz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>, Tal Nisan <tnisan@redhat.com>
Message-ID: <1491bc75-e1ee-b63b-a75b-6d5c39faab7c@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
 <a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
 <cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
 <0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
 <b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
 <20170828025706.GA18194@lemon.lan>
 <923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
 <CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
In-Reply-To: <CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-29 11:26, Yaniv Lavi (Dary) wrote:
>=20
>=20
> YANIV=C2=A0LAVI (YANIV=C2=A0DARY)
>=20
> SENIOR TECHNICAL PRODUCT MANAGER
>=20
> Red Hat=C2=A0Israel Ltd. <https://www.redhat.com/>
>=20
> 34 Jerusalem Road, Building A, 1st floor
>=20
> Ra'anana, Israel 4350109
>=20
> ylavi@redhat.com <mailto:ylavi@redhat.com>=C2=A0 =C2=A0=C2=A0T:=C2=A0+9=
72-9-7692306
> <tel:+972-9-7692306>/8272306 <tel:8272306>=C2=A0 =C2=A0=C2=A0=C2=A0F:=C2=
=A0+972-9-7692223
> <tel:+972-9-7692223>=C2=A0=C2=A0 =C2=A0IM:=C2=A0ylavi
>=20
> <https://red.ht/sig>	TRIED. TESTED. TRUSTED. <https://redhat.com/truste=
d>
>=20
> @redhatnews <https://twitter.com/redhatnews>=C2=A0=C2=A0=C2=A0Red Hat
> <https://www.linkedin.com/company/red-hat>=C2=A0=C2=A0=C2=A0Red Hat
> <https://www.facebook.com/RedHatInc>
>=20
>=20
> On Mon, Aug 28, 2017 at 9:11 PM, John Snow <jsnow@redhat.com
> <mailto:jsnow@redhat.com>> wrote:
>=20
>=20
>=20
>     On 08/27/2017 10:57 PM, Fam Zheng wrote:
>     > On Fri, 08/25 15:44, Max Reitz wrote:
>     >> Well, OK.=C2=A0 The main argument against supporting anything bu=
t qcow2 is
>     >> "if you want features, use qcow2; and we are working on making
>     qcow2 as
>     >> fast as possible."=C2=A0 I think that's a very good argument sti=
ll.=C2=A0
>     At some
>     >> point I (and probably others, too) had the idea of making qcow2
>     files in
>     >> raw layout:
>     >
>     >
>     > Yes! I think this idea makes a whole lot of sense, too. Metadata
>     tables can be
>     > generated so old implementation can still use it.
>     >
>     > Fam
>     >
>     >> Have the data as a blob, just like a raw file, padded by
>     >> metadata around it.=C2=A0 An autoclear flag would specify that t=
he
>     qcow2 file
>     >> is in this format, and if so, you could simply access it like a
>     raw file
>     >> and should have exactly the same speed as a raw file.=C2=A0 Mayb=
e that
>     would
>     >> solve this whole issue, too?
>=20
>     I wonder if this would be sufficient to alleviate the desire to use=
 raw
>     files...
>=20
>     (Eh, well, realistically, someone's still always going to ask if th=
ey
>     can use various features with non-qcow2 files...)
>=20
>     Nir, Yaniv; any input?
>=20
>=20
> We are using raw format for performance reasons.

Using raw layout for the data in a qcow2 file would give you exactly the
same performance as raw.

(Or better "should", but I can't think of a reason why it would not.)

Max

> As we have many customers that currently use this format, not support i=
t
> would be a blocker the use of the feature.
> At a minimum we would require ability to convert raw to qcow2 raw-layou=
t.
>=20
> Please also consider that we are planning to go on the OSP route of LUN=

> per disk and would still want the tracking to work.
> I makes sense that for that and raw format you will be able to save the=

> mapping to another file other than a qcow.
> =C2=A0
>=20
>=20
>     (Context: We're debating how to add persistent bitmaps to raw files=
 as I
>     was informed that RHV was 'asking about it.' Max is reminding me th=
ere
>     is a proposal for a style of QCOW2 that uses a raw layout for data,=

>     mitigating or eliminating any performance hits related to the L2 ca=
che.
>     What I am not aware of is why RHV would use raw files for any purpo=
se.
>     Is it performance? Simplicity? Could RHV use a raw-layout qcow2?)
>=20
>     --js
>=20
>=20



--W3StoH1sa3UioEh6ih0SFlU6Lo5NPgKHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmmlQUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYHMH/2tSKnEI+XZySpfBsTnQxSocjnk8wxvW
dDCxiGytE//HoPSll+RENGwBj1Sn4ie/7FZKu82ccQmRilUG5XZcg0RFZPTXogDA
fxAI8e+Aq7AvhKSkVGwvWY1yBpn1QOVaBPaAZ7OZG6m1xQchDCw2UgxJwERMkKST
hmELVDhz8o+GcMRTX1p7EFFLqbMqIv0/2VQIJfrTk1tqoVqjQ6Zei3zajty5ZopP
ioLGs75/SJ8UdS8B8o9Bsq+UGCWpeUtmQ+6e5K+BzvWsJiGztzQx/whqxghva2P0
SjlmazkSYiIKXuKZ0HJ02S28326v3afSsbkXpzMVYLyOslBPIuE4/N8=
=Li4S
-----END PGP SIGNATURE-----

--W3StoH1sa3UioEh6ih0SFlU6Lo5NPgKHw--
