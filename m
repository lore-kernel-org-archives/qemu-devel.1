Received: from eggs.gnu.org ([2001:4830:134:3::10]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ek9ST-0000LQ-5Q
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ek9SO-0007qy-R9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:15:21 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:42388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ek9SO-0007p2-KR
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:15:16 -0500
Received: by mail-wr0-x233.google.com with SMTP id 41so8379449wrc.9
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:15:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Feb 2018 14:15:13 +0000
Message-Id: <20180209141514.18840-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] Travis speed-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 04bb7fe2bf55bdf66d5b7a5a719b40bbb4048178:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180208' into staging (2018-02-08 17:41:15 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-travis-speedup-090218-1

for you to fetch changes up to 04200a1674bfc20784f1fc105cbc22bd9be779e8:

  .travis.yml: add --disable-linux-user for some jobs (2018-02-09 14:09:24 +0000)

----------------------------------------------------------------
One patch to mitigate Travis timeouts

----------------------------------------------------------------
Alex Bennée (1):
      .travis.yml: add --disable-linux-user for some jobs

 .travis.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.15.1
