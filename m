Received: from eggs.gnu.org ([2001:4830:134:3::10]:33937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.fuchs91@icloud.com>) id 1fDwQb-0007aj-CV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.fuchs91@icloud.com>) id 1fDwQX-00034Q-Bz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:24:33 -0400
Received: from mr11p00im-asmtp003.me.com ([17.110.69.254]:53788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <d.fuchs91@icloud.com>)
	id 1fDwQX-00032Z-2n
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:24:29 -0400
Received: from process-dkim-sign-daemon.mr11p00im-asmtp003.me.com by
	mr11p00im-asmtp003.me.com
	(Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built
	Jun 7 2017)) id <0P8400B005J3YC00@mr11p00im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Wed, 02 May 2018 18:24:00 +0000 (GMT)
Message-id: <0P8400M5O5RWWW30@mr11p00im-asmtp003.me.com>
MIME-version: 1.0
From: Dominique Fuchs <d.fuchs91@icloud.com>
Date: Wed, 02 May 2018 20:23:57 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

C:\msys64\mingw64\bin\ar.exe: creating libfdt/libfdt.a
make[1]: *** No rule to make target =E2=80=9E/home/Dominique/qemu/capstone/=
capstone.lib=E2=80=9C.  Stop.
make: *** [Makefile:503: subdir-capstone] Error 2

I just stumbled across the same error while building qemu 2.12 on MSYS2/min=
gw64, which led me to this conversation from january. According to this lis=
t, there was no final solution to this, as this still happens in build chai=
n for 2.12 and no further comments were made. Did I miss something elsewher=
e?

Dominique Fuchs
