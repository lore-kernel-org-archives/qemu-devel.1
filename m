Received: from eggs.gnu.org ([209.51.188.92]:38513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0DHB-0004BU-Cr
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0DHA-0005QH-Od
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:38:37 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  2 Mar 2019 23:38:23 +0100
Message-Id: <20190302223825.11192-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] util/error: Trivial cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

Trivial cleanups suggested by Daniel and Thomas.

Philippe Mathieu-Daud=C3=A9 (2):
  util/error: Remove an unnecessary NULL check
  util/error: Remove unnecessary saved_errno

 util/error.c | 7 -------
 1 file changed, 7 deletions(-)

--=20
2.20.1
