Received: from eggs.gnu.org ([2001:4830:134:3::10]:58080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHS8j-0001dH-ES
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHS8g-0002fr-Es
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:24:53 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 30 Oct 2018 12:23:26 +0100
Message-Id: <20181030112337.17973-10-laurent@vivier.eu>
In-Reply-To: <20181030112337.17973-1-laurent@vivier.eu>
References: <20181030112337.17973-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 09/20] qemu-iotests: make 218 executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefano Stabellini <sstabellini@kernel.org>, qemu-trivial@nongnu.org, qemu-block@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, xen-devel@lists.xenproject.org, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>, Michael Walle <michael@walle.cc>, Markus Armbruster <armbru@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

Commit 990dc39c made all tests executable at the time, but 218 came in
later, and missing those permissions.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181004161852.11673-4-crosa@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/qemu-iotests/218 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/218

diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
old mode 100644
new mode 100755
-- 
2.17.2
