Received: from eggs.gnu.org ([2001:4830:134:3::10]:38392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Mp-0008E0-F4
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gR1Mo-0005Dl-KG
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:50:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 25 Nov 2018 21:49:35 +0100
Message-Id: <20181125205000.10324-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 00/25] MAINTAINERS: Add various missing
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, "Daniel P . Berrange" <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Helge Deller <deller@gmx.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Markovic <smarkovic@wavecomp.com>, Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>

Hi,

This cleanup effort is inspired by Markus "Full list of unmaintained file=
s"
from the "MAINTAINERS leaves too many files uncovered" thread:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04270.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (25):
  MAINTAINERS: Fix ACPI tests data files path
  MAINTAINERS: Add a missing entry to the SPARC CPU
  MAINTAINERS: Add missing entries to the X86 section (AMD SEV)
  MAINTAINERS: Add missing entries for the Xilinx ZynqMP machine
  MAINTAINERS: Add missing entries for the Jazz machine
  MAINTAINERS: Add a missing entry for the Xilinx S3A-DSP 1800 machine
  MAINTAINERS: Add a missing entry for the Fulong 2E machine
  MAINTAINERS: Add a missing entry for the Old World machines
  MAINTAINERS: Add a missing entry for the sun4m machines
  MAINTAINERS: Add missing entries for the sun4u machines
  MAINTAINERS: Add missing entries for the PC machines
  MAINTAINERS: Add missing entries to the PC Chipset section
  MAINTAINERS: Add missing entries to VFIO
  MAINTAINERS: Add missing entries to the vhost section
  MAINTAINERS: Add missing entries for the Canon DIGIC machine
  MAINTAINERS: Add missing entries for the MPS2 machine
  MAINTAINERS: Add a missing entry to SPICE
  MAINTAINERS: Add missing entries for the QObject section
  MAINTAINERS: Add a missing entry to the QMP section
  MAINTAINERS: Add missing test entries to the Cryptography section
  MAINTAINERS: Add a missing entry for the NVDIMM device
  MAINTAINERS: Add a missing entry to the New World machines
  MAINTAINERS: Add an entry for the Dino machine
  MAINTAINERS: Use my work email to review Build and test automation patc=
hes
  MAINTAINERS: Remove duplicate entries of qemu-devel@nongnu.org

 MAINTAINERS | 69 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 17 deletions(-)

--=20
2.17.2
