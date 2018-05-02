Received: from eggs.gnu.org ([2001:4830:134:3::10]:58781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDn6H-0002qZ-Gi
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDn6E-0004YH-F7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:26:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fDn6E-0004Xm-A2
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:26:54 -0400
Date: Wed, 2 May 2018 10:26:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180502102642.4759c994.cohuck@redhat.com>
In-Reply-To: <CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
	<CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Liviu Ionescu <ilg@livius.net>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>

On Wed, 2 May 2018 01:02:49 -0700
Liviu Ionescu <ilg@livius.net> wrote:

> On 2 May 2018 at 10:59:07, Daniel P. Berrang=C3=A9 (berrange@redhat.com) =
wrote:
>=20
> > Our deprecation policy lets us include incompatible
> > changes in *any* release. =20
>=20
> can you elaborate on this?
>=20
> where is this policy defined?

See https://wiki.qemu.org/Features/LegacyRemoval, especially "Rules for
removing an interface". An incompatible change is basically a subset of
removing.
