Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQayX-0001JI-Mz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQayU-0006aS-Fp
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:03:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 29 Jun 2017 12:03:03 -0300
Message-Id: <20170629150308.22766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/5] MAINTAINERS: update
 TCG/KVM/Xen/TCI/Unimplemented device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

As requested by Thomas Huth, I separated these patches from my previous series
"removal of tci (tcg interpreter)".

TCG/KVM/Xen/TCI related files were moved in commits a9ded601..244f1441, update
MAINTAINERS to match the new paths.

Also add an entry for the "Unimplemented" device and voluntary myself as
reviewer.

Regards,

Phil.

v2:
- fix inaccurate Xen commit message (review feedback from Anthony PERARD)
- add "Unimplemented" device

v1:
- update TCG/KVM/Xen/TCI entries

Philippe Mathieu-Daudé (5):
  MAINTAINERS: update TCG entries
  MAINTAINERS: update KVM entries
  MAINTAINERS: update Xen entries
  MAINTAINERS: update TCI entry
  MAINTAINERS: add entry for "Unimplemented" device

 MAINTAINERS | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.13.1
