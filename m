Received: from eggs.gnu.org ([2001:4830:134:3::10]:45041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1e5gbr-0006wU-KZ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1e5gbo-00087Q-3V
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:47 -0400
From: Paul Burton <paul.burton@mips.com>
Date: Fri, 20 Oct 2017 16:21:14 -0700
Message-ID: <20171020232114.5475-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Update Paul Burton's email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>
Cc: Paul Burton <paul.burton@imgtec.com>, Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, Yongbok Kim <yongbok.kim@imgtec.com>

From: Paul Burton <paul.burton@imgtec.com>

Update my email address from paul.burton@imgtec.com to
paul.burton@mips.com, since MIPS will soon no longer be a part of
Imagination Technologies & as such the @imgtec.com address will soon
cease to function.

A mapping is added in .mailmap such that git reports the new @mips.com
address, and get_maintainer.pl in turn reports it when examining git
history. Whilst here add a mapping for my also-defunct
paul@archlinuxmips.org email address too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 28defa1b2c..dda7e3fa5f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -10,6 +10,8 @@ Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046a42c-6fe2-
 Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
+Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 # There is also a:
diff --git a/MAINTAINERS b/MAINTAINERS
index 12175425a7..0a400c57c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -642,7 +642,7 @@ S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 
 Boston
-M: Paul Burton <paul.burton@imgtec.com>
+M: Paul Burton <paul.burton@mips.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
-- 
2.14.2
