Received: from eggs.gnu.org ([2001:4830:134:3::10]:57115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cnw0x-00067b-Dv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 19:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cnw0t-00040Z-HM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 19:38:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42354
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cnw0t-0003yy-Aj
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 19:37:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2ENXeMA006537
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 19:37:57 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 296nfxc5j7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 19:37:57 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 14 Mar 2017 19:37:56 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 14 Mar 2017 18:37:47 -0500
Message-Id: <148953466730.19276.1541285718972438692@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc0 is now available
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
first release candidate for the QEMU 2.9 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.9.0-rc0.tar.xz
  http://download.qemu-project.org/qemu-2.9.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 2.9 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.9

The dates have all been pushed back a week due to delays with the
initial RC.

Please add entries to the ChangeLog for the 2.9 release below:

  http://wiki.qemu.org/ChangeLog/2.9
