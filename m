Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dNgQ0-0001d1-Dv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dNgPw-0001Ng-Cg
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:15:40 -0400
Received: from st13p21im-asmtp004.me.com ([17.164.152.26]:36037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tblodt@icloud.com>) id 1dNgPw-0001LH-3e
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:15:36 -0400
Received: from process-dkim-sign-daemon.st13p21im-asmtp004.me.com by
	st13p21im-asmtp004.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016)) id <0ORW00400I7KRW00@st13p21im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:15:26 +0000 (GMT)
Received: from icloud.com ([127.0.0.1]) by st13p21im-asmtp004.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016))
	with ESMTPSA id <0ORW00CT8I9GH020@st13p21im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:15:25 +0000 (GMT)
From: Theodore Dubois <tblodt@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-id: <33C62801-DFAA-49FA-BBDE-D9622810C8EB@icloud.com>
Date: Wed, 21 Jun 2017 07:15:11 -0700
Subject: [Qemu-devel] TLB addend field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, I=E2=80=99ve got a question about the addend field in the TLB. Why =
use this instead of a pointer to the host page? I would think the speed =
difference would be unmeasurable.

~Theodore
