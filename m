Received: from eggs.gnu.org ([2001:4830:134:3::10]:42626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1eBjzb-00018p-Vp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1eBjzV-0004Cs-Be
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:17 -0500
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Mon, 6 Nov 2017 16:07:44 +0000
Message-ID: <20171106160744.14399-4-yongbok.kim@mips.com>
In-Reply-To: <20171106160744.14399-1-yongbok.kim@mips.com>
References: <20171106160744.14399-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 3/3] MAINTAINERS: Update Paul Burton's email
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Burton <paul.burton@imgtec.com>, Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-trivial@nongnu.org

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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[Yongbok Kim:
  Updated message subject]
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 5aec1bd..ee81ac8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -11,6 +11,8 @@ Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c0=
46a42c-6fe2-441c-8c8c-7
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c=
-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-=
71466251a162>
+Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251=
a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 # There is also a:
diff --git a/MAINTAINERS b/MAINTAINERS
index abbf2b4..0cd4d02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -642,7 +642,7 @@ S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
=20
 Boston
-M: Paul Burton <paul.burton@imgtec.com>
+M: Paul Burton <paul.burton@mips.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
--=20
2.4.5
