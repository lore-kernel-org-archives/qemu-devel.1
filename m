Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dkCOu-0006fg-FC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dkCOr-0007sj-9X
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:51:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42820
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dkCOr-0007rM-36
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:51:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7MGpNb8068012
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 12:51:30 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cgr5p92a0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 12:51:21 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 22 Aug 2017 12:50:24 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA9eJ18cPj=MBhCftmVvOBPCmFtDqSKOM8aBH9d+uVuv4Q@mail.gmail.com>
References: <150283106173.12142.14640827565327335906@loki>
	<CAFEAcA9eJ18cPj=MBhCftmVvOBPCmFtDqSKOM8aBH9d+uVuv4Q@mail.gmail.com>
Date: Tue, 22 Aug 2017 11:50:09 -0500
Message-Id: <150342060911.16351.13360526764887940185@loki>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Quoting Peter Maydell (2017-08-22 11:20:18)
> On 15 August 2017 at 22:04, Michael Roth <mdroth@linux.vnet.ibm.com> wrot=
e:
> > Hello,
> >
> > On behalf of the QEMU Team, I'd like to announce the availability of the
> > fourth release candidate for the QEMU 2.10 release.  This release is me=
ant
> > for testing purposes and should not be used in a production environment.
> >
> >   http://download.qemu-project.org/qemu-2.10.0-rc3.tar.xz
> >   http://download.qemu-project.org/qemu-2.10.0-rc3.tar.xz.sig
> >
> > A note from the maintainer:
> >
> >   We don't currently know of any outstanding release critical bugs,
> >   so unless any last minute showstoppers appear next week, we hope
> >   to be able to release 2.10.0 on schedule on the 22nd. If any
> >   further release critical bugs are fixed we'll release an rc4 on
> >   the 22nd and the final release a week after that.
> =

> We've had a few late-breaking PPC host bugs that we need
> to fix, so we'll tag rc3 either today or more likely tomorrow
> and then have the final release next week.

Ok, thanks for the heads up.

> =

> thanks
> -- PMM
>=20
