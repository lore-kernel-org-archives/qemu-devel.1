Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK7pn-0000Yt-CZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eK7pj-0004Ov-Cu
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:15:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eK7pi-0004Nc-Th
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:15:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATJEmlr128647
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:15:45 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ej21nta77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:15:44 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 14:15:43 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <151198269829.22232.14116010638342203089@sif>
References: <151198269829.22232.14116010638342203089@sif>
Date: Wed, 29 Nov 2017 13:15:33 -0600
Message-Id: <151198293377.22232.18254151781840857503@sif>
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

Quoting Michael Roth (2017-11-29 13:11:38)
> Hello,
> =

> On behalf of the QEMU Team, I'd like to announce the availability of the
> fourth release candidate for the QEMU 2.11 release.  This release is meant
> for testing purposes and should not be used in a production environment.
> =

>   http://download.qemu-project.org/qemu-2.11.0-rc3.tar.xz
>   http://download.qemu-project.org/qemu-2.11.0-rc3.tar.xz.sig
> =

> You can help improve the quality of the QEMU 2.11 release by testing this
> release and reporting bugs on Launchpad:
> =

>   https://bugs.launchpad.net/qemu/
> =

> The release plan, as well a documented known issues for release
> candidates, are available at:
> =

>   http://wiki.qemu.org/Planning/2.11

A note from the maintainer:

 Hopefully this will be the final release candidate for 2.11, so
 testing should concentrate on the fixes that went into this rc.
 Unless we need to fix any showstopper bugs the plan is to make the
 final release on the 28th.
