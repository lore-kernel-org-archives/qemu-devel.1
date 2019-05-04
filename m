Received: from eggs.gnu.org ([209.51.188.92]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMupS-0004Ui-FP
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMupR-00054q-D1
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:35:50 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  4 May 2019 15:35:38 +0200
Message-Id: <20190504133540.19758-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] roms: Add 'clean' make rule and EDK2
 documentation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

Two trivial patches waiting Laszlo's series to land.

Since v1:
- rebased

v1:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01589.html
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01598.html

Philippe Mathieu-Daud=C3=A9 (2):
  roms: Correct the EDK2_BASETOOLS_OPTFLAGS variable description
  roms: List and describe the Makefile 'clean' rule

 roms/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--=20
2.20.1
