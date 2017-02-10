Received: from eggs.gnu.org ([2001:4830:134:3::10]:52680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccCkd-000658-UA
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccCka-0002Cw-Lg
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:04:43 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccCka-0002Cc-Fj
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:04:40 -0500
Received: by mail-wr0-x22d.google.com with SMTP id o16so110046175wra.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:04:40 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Feb 2017 15:04:50 +0000
Message-Id: <20170210150452.21550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] Travis updates
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

The following changes since commit 7d2c6c95511e42dffe2b263275e09957723d0ff4:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170206-1' into staging (2017-02-06 11:44:08 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-travis-10022017-1

for you to fetch changes up to 78a22af040b8ea7c26d52755facdc332ac7bac46:

  .travis.yml: split VM based builds (2017-02-10 13:19:56 +0000)

----------------------------------------------------------------
One minor fix and a build split to reduce timeouts.

----------------------------------------------------------------
Alex Bennée (2):
      .travis.yml: don't specify CONFIG twice
      .travis.yml: split VM based builds

 .travis.yml | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

-- 
2.11.0
