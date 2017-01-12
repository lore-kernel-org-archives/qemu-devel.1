Received: from eggs.gnu.org ([2001:4830:134:3::10]:56130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRfFb-0006nz-4a
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRfFW-0003ZZ-44
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:07 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cRfFV-0003Yo-Rd
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:02 -0500
Received: by mail-wm0-x234.google.com with SMTP id c206so19131162wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 05:17:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Jan 2017 13:16:56 +0000
Message-Id: <20170112131658.19837-1-alex.bennee@linaro.org>
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
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit b44486dfb9447c88e4b216e730adcc780190852c:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1' into staging (2017-01-10 14:52:34 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-travis-20170112-1

for you to fetch changes up to ae1a772c5607f25cbdc80063f0f5a85290434058:

  travis: add Trusty with clang stable build (2017-01-12 10:04:17 +0000)

----------------------------------------------------------------
A couple of fixes to reduce the matrix some more that just missed the
last iteration.

----------------------------------------------------------------
Alex Bennée (1):
      travis: add Trusty with clang stable build

Daniel P. Berrange (1):
      travis: trim out most clang builds

 .travis.yml | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.11.0
