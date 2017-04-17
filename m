Received: from eggs.gnu.org ([2001:4830:134:3::10]:55068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1d02wa-00042W-DB
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 05:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1d02wV-0000cH-CN
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 05:27:36 -0400
Received: from nm3-vm9.bullet.mail.ir2.yahoo.com ([212.82.96.98]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1d02wV-0000au-2G
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 05:27:31 -0400
Date: Mon, 17 Apr 2017 09:27:27 +0000 (UTC)
From: oussema ben khedher <oussemakeder@yahoo.fr>
Reply-To: oussema ben khedher <oussemakeder@yahoo.fr>
Message-ID: <1337526951.2414198.1492421247871@mail.yahoo.com>
MIME-Version: 1.0
References: <1337526951.2414198.1492421247871.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] need help about trace reconstruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

hi
=C2=A0i m comparing the trace of execution of reconstruction of trace instr=
uction of a code running in real board and the trace of=C2=A0=C2=A0the same=
 code running in qemu ..
and i found that there is some function not called in the reconstruction of=
 qemu trace ..
i guess that qemu do some optimization or there is another raison for that
