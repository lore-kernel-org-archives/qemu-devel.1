Received: from eggs.gnu.org ([2001:4830:134:3::10]:59084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dczHR-0006LW-SR
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 15:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dczHP-0003vi-5d
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 15:26:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dczHO-0003ol-SN
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 15:26:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v72JOILt058769
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 15:26:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3hrwsn63-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 15:26:00 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 2 Aug 2017 15:25:59 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 02 Aug 2017 14:25:48 -0500
Message-Id: <150170194851.27115.7749410999055362925@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc1 is now available
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 2.10 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.10.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-2.10.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 2.10 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.10

Please add entries to the ChangeLog for the 2.10 release below:

  http://wiki.qemu.org/ChangeLog/2.10
