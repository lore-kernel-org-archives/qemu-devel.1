Received: from eggs.gnu.org ([2001:4830:134:3::10]:59170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK81A-00030r-V2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK817-00038d-Nr
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:27:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50536
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eK817-00038S-IO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:27:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATJNmG2035864
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:27:29 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ej1pakmhm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:27:29 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 14:27:28 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <151198293377.22232.18254151781840857503@sif>
References: <151198269829.22232.14116010638342203089@sif>
	<151198293377.22232.18254151781840857503@sif>
Date: Wed, 29 Nov 2017 13:27:18 -0600
Message-Id: <151198363863.31225.2834489934392805913@sif>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Quoting Michael Roth (2017-11-29 13:15:33)
> Quoting Michael Roth (2017-11-29 13:11:38)
> > Hello,
> > =

> > On behalf of the QEMU Team, I'd like to announce the availability of the
> > fourth release candidate for the QEMU 2.11 release.  This release is me=
ant
> > for testing purposes and should not be used in a production environment.
> > =

> >   http://download.qemu-project.org/qemu-2.11.0-rc3.tar.xz
> >   http://download.qemu-project.org/qemu-2.11.0-rc3.tar.xz.sig
> > =

> > You can help improve the quality of the QEMU 2.11 release by testing th=
is
> > release and reporting bugs on Launchpad:
> > =

> >   https://bugs.launchpad.net/qemu/
> > =

> > The release plan, as well a documented known issues for release
> > candidates, are available at:
> > =

> >   http://wiki.qemu.org/Planning/2.11
> =

> A note from the maintainer:
> =

>  Hopefully this will be the final release candidate for 2.11, so
>  testing should concentrate on the fixes that went into this rc.
>  Unless we need to fix any showstopper bugs the plan is to make the
>  final release on the 28th.

Sorry, the 28th was the planned date for rc3, that should be December
5th for the tentative final release date unless another RC is needed.
