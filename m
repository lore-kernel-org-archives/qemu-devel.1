Received: from eggs.gnu.org ([2001:4830:134:3::10]:33237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGGb-0003qq-Ij
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZGGX-0006Qm-Gu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:22:36 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:56:03 +0100
Message-Id: <20181218115615.1499-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/12] MAINTAINERS: Add various missing
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This cleanup effort is inspired by Markus "Full list of unmaintained file=
s"
from the "MAINTAINERS leaves too many files uncovered" thread:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04270.html

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04994.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (12):
  MAINTAINERS: Add missing entries to the X86 section (AMD SEV)
  MAINTAINERS: Add missing entries for the sun4u machines
  MAINTAINERS: Add missing entries for the PC machines
  MAINTAINERS: Add missing entries to VFIO and NVMe
  MAINTAINERS: Add missing entries for the QObject section
  MAINTAINERS: Add missing test entries to the Cryptography section
  MAINTAINERS: Add an entry for the Dino machine
  MAINTAINERS: Add maintainers to the Linux subsystem
  MAINTAINERS: Add maintainer to the POSIX subsystem
  MAINTAINERS: Orphanize the 'CPU (QOM)' subsystem
  MAINTAINERS: Orphanize the 'GDB stub' subsystem
  MAINTAINERS: Add maintainer to the TCG/i386 subsystem

 MAINTAINERS | 55 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 11 deletions(-)

--=20
2.17.2
