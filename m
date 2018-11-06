Received: from eggs.gnu.org ([2001:4830:134:3::10]:53805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJy4x-0000zx-OQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJxqI-000062-E7
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:40:19 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1d1c0473-cd71-c7de-9d56-072596501e4c@redhat.com>
Date: Tue, 6 Nov 2018 10:40:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] How to use the 'canon-a1100' machine?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>


 Hi,

does anybody know whether the "canon-a1100" machine in QEMU is still
usable, or rather how it can be used at all?

According to
http://lists.infradead.org/pipermail/barebox/2014-July/020327.html there
should be support for "-serial stdio" and on
https://lists.gnu.org/archive/html/qemu-devel/2013-10/msg02969.html
there is a link to a firmware image ... but when I try to use it, there
is simply no output on stdio...

Is there a way this machine can still be tested in QEMU?

 Thomas
