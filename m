Received: from eggs.gnu.org ([2001:4830:134:3::10]:51780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dsebA-00087K-Bs
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 20:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dseb5-0007br-Fv
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 20:35:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dseb5-0007aK-7H
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 20:35:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8F0YLnk040648
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 20:35:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyyw626n6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 20:35:03 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 20:35:02 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <04707d3f-118b-aeaa-0c4c-89ccb1475820@redhat.com>
References: <1503049022-14749-1-git-send-email-hare@suse.de>
	<09f093ef-a073-7374-0f40-330febc7c196@redhat.com>
	<04707d3f-118b-aeaa-0c4c-89ccb1475820@redhat.com>
Date: Thu, 14 Sep 2017 19:21:25 -0500
Message-Id: <150543488598.22700.2165222026626673271@loki>
Subject: Re: [Qemu-devel] [PATCH] scsi-bus: correct responses for INQUIRY
 and REQUEST SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>, qemu-devel@nongnu.org

Quoting Paolo Bonzini (2017-08-22 08:20:23)
> On 19/08/2017 00:55, Laszlo Ersek wrote:
> > Reported-by: Laszlo Ersek <lersek@redhat.com>
> > Fixes: ded6ddc5a7b95217557fa360913d1213e12d4a6d
> =

> And also:
> =

> Cc: qemu-stable@nongnu.org

FYI patch freeze for v2.10.1 is Sep 25th. Hannes, were you planning to
resend with the suggested commit msg changes? (Or maybe having a willing
maintainer add them?)

> =

> =

> Thanks to both!
> =

> Paolo
>=20
