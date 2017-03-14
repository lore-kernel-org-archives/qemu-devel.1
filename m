Received: from eggs.gnu.org ([2001:4830:134:3::10]:40037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cnlXB-00074T-4a
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cnlX7-0006vG-7f
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:26:37 -0400
Received: from nm26-vm6.bullet.mail.ir2.yahoo.com ([212.82.97.48]:40912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cnlX6-0006un-Rw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:26:33 -0400
Date: Tue, 14 Mar 2017 12:26:30 +0000 (UTC)
From: oussema ben khedher <oussemakeder@yahoo.fr>
Reply-To: oussema ben khedher <oussemakeder@yahoo.fr>
Message-ID: <1170650943.9059154.1489494390237@mail.yahoo.com>
MIME-Version: 1.0
References: <1170650943.9059154.1489494390237.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] searching the function that really execute tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Im using the gdbserver to =C2=A0know what qemu exactly doing..in theory i f=
ind that cpu_tb_exec () is the function that execute TB but when i put a br=
eak point in this function the qemu did not stop..this have relation with t=
he inline function or not
