Received: from eggs.gnu.org ([2001:4830:134:3::10]:47978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rgusai97@gmail.com>) id 1fBz24-0007rg-Ok
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rgusai97@gmail.com>) id 1fBz23-0000ms-Ux
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:47:08 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:36134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rgusai97@gmail.com>) id 1fBz23-0000mR-Pc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:47:07 -0400
Received: by mail-oi0-x235.google.com with SMTP id v2-v6so935184oif.3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 01:47:07 -0700 (PDT)
MIME-Version: 1.0
From: Rahul Gusai <rgusai97@gmail.com>
Date: Fri, 27 Apr 2018 14:17:05 +0530
Message-ID: <CAOCZyUWKV6fko1gmdNvJdBO4pDLAjNVgVdBpYJkBfPUA42Fv7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] POD document had syntax errors at /usr/bin/pod2man
 line 68.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am getting the following error while trying to compile the binaries for
QEMU emulator.







*GEN   qemu.1qemu.pod around line 95: Non-ASCII character seen before
=3Dencoding in 'Sch=EF=BF=BDtz.'. Assuming UTF-8POD document had syntax err=
ors at
/usr/bin/pod2man line 68.Makefile:297: recipe for target 'qemu.1'
failedmake: *** [qemu.1] Error 255make: *** Deleting file 'qemu.1'*
What could be the issue ?
