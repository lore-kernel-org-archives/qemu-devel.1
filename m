Received: from eggs.gnu.org ([209.51.188.92]:60854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wD-0007LO-85
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wA-0007wA-Lz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gm3w6-0007mP-9w
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so77683wra.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:50:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 22 Jan 2019 21:50:08 +0000
Message-Id: <20190122215016.18697-4-alex.bennee@linaro.org>
In-Reply-To: <20190122215016.18697-1-alex.bennee@linaro.org>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v3 03/11] berkeley-testfloat-3: pull changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

From: "Emilio G. Cota" <cota@braap.org>

- fail: constify fail_programName

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/berkeley-testfloat-3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
index ca9fa2ba05..5a59dcec19 160000
--- a/tests/fp/berkeley-testfloat-3
+++ b/tests/fp/berkeley-testfloat-3
@@ -1 +1 @@
-Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
+Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
-- 
2.17.1
