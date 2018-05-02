Received: from eggs.gnu.org ([2001:4830:134:3::10]:56538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDmto-0006Hg-FK
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDmtk-0002Sj-EN
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:14:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDmtk-0002Re-8s
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:14:00 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
	<CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <de11d2a4-3bd0-42e3-5bff-79c160e9c5df@redhat.com>
Date: Wed, 2 May 2018 10:13:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 02.05.2018 10:02, Liviu Ionescu wrote:
> On 2 May 2018 at 10:59:07, Daniel P. Berrang=C3=A9 (berrange@redhat.com=
) wrote:
>=20
>> Our deprecation policy lets us include incompatible
>> changes in *any* release.
>=20
> can you elaborate on this?
>=20
> where is this policy defined?

https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features

It took quite a while to get a consensus on that policy, so I don't
think that we want to sacrifice that for semver.

 Thomas
