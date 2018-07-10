Received: from eggs.gnu.org ([2001:4830:134:3::10]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fcyxl-0005CU-F1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fcyxi-00008H-MR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:10:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57432
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fcyxi-00007z-6n
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:10:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6AK9FlZ012825
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 16:10:13 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k4yhmm349-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 16:10:13 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 10 Jul 2018 14:10:12 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2018 15:10:01 -0500
Message-Id: <153125340100.30710.7168106493152609709@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.0-rc0 is now available
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
first release candidate for the QEMU 3.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.0.0-rc0.tar.xz
  http://download.qemu-project.org/qemu-3.0.0-rc0.tar.xz.sig

A note from the maintainer:

  Here's the first release candidate for the upcoming QEMU 3.0 release.
  Why 3.0? Well, we felt that our version numbers were getting a bit
  unwieldy, and since this year is QEMU's 15th birthday it seemed like a
  good excuse to roll over the major digit. Going forward we plan to
  increment the major version once a year, for the first release of the
  year. Don't read too much into it: it doesn't imply a drastic
  compatibility break.
  =

  Rumours of our triskaidekaphobia have been greatly exaggerated :-)

You can help improve the quality of the QEMU 3.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.0

Please add entries to the ChangeLog for the 3.0 release below:

  http://wiki.qemu.org/ChangeLog/3.0

Thank you to everyone involved!
