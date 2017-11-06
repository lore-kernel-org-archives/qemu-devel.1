Received: from eggs.gnu.org ([2001:4830:134:3::10]:42664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1eBjzg-0001D0-JB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1eBjza-0004FI-H3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:24 -0500
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Mon, 6 Nov 2017 16:07:43 +0000
Message-ID: <20171106160744.14399-3-yongbok.kim@mips.com>
In-Reply-To: <20171106160744.14399-1-yongbok.kim@mips.com>
References: <20171106160744.14399-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 2/3] MAINTAINERS: Update James Hogan's email
 address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>

From: James Hogan <james.hogan@imgtec.com>

Update my imgtec.com email address to my kernel.org one in MAINTAINERS
as MIPS will soon no longer be part of Imagination Technologies, and add
a mapping in .mailcap so get_maintainer.pl reports the right address.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
[Yongbok Kim:
  Updated message subject]
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 28defa1..5aec1bd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -8,6 +8,7 @@ Aurelien Jarno <aurelien@aurel32.net> aurel32 <aurel32@c046a42c-6fe2-441c-8c8c-7
 Blue Swirl <blauwirbel@gmail.com> blueswir1 <blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162>
 Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162>
 Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
+James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
diff --git a/MAINTAINERS b/MAINTAINERS
index 44aa71e..abbf2b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -285,7 +285,7 @@ S: Maintained
 F: target/arm/kvm.c
 
 MIPS
-M: James Hogan <james.hogan@imgtec.com>
+M: James Hogan <jhogan@kernel.org>
 S: Maintained
 F: target/mips/kvm.c
 
-- 
2.4.5
