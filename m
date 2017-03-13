Received: from eggs.gnu.org ([2001:4830:134:3::10]:52572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cnLZl-0001Cf-OE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 04:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cnLZi-0007Gx-IZ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 04:43:33 -0400
Received: from nm49-vm0.bullet.mail.ne1.yahoo.com ([98.138.121.128]:41193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1cnLZi-0007EQ-A0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 04:43:30 -0400
Date: Mon, 13 Mar 2017 08:40:41 +0000 (UTC)
From: oussema ben khedher <oussemakeder@yahoo.fr>
Reply-To: oussema ben khedher <oussemakeder@yahoo.fr>
Message-ID: <928382347.7043935.1489394441716@mail.yahoo.com>
MIME-Version: 1.0
References: <928382347.7043935.1489394441716.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] how to enable trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

i used simple trace back end to trace guest code running in qemu but when i=
 tried to recompile and disable this trace i have always this problem
=C2=A0undefined reference to `trace_record_write_u64'
thanks for your help=C2=A0
