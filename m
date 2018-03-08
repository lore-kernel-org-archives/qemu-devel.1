Received: from eggs.gnu.org ([2001:4830:134:3::10]:44341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etx4y-0001mM-Ja
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etx4u-00085v-LO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:03:36 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:38069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etx4u-00085J-Eg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:03:32 -0500
Received: by mail-wr0-x235.google.com with SMTP id n7so6001357wrn.5
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:03:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Mar 2018 15:03:28 +0000
Message-Id: <20180308150329.27238-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] disable broken shippable build
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

The following changes since commit 0ab4537f08e09b13788db67efd760592fb7db769:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-03-07-1' into staging (2018-03-08 12:56:39 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-shippable-disable-ppc-080318-1

for you to fetch changes up to b2dba411cf5afc6771e0dd9900fa2b5031a686ac:

  .shippable.yml: disable powerpc-cross image (2018-03-08 14:34:41 +0000)

----------------------------------------------------------------
One fix to disable broken ppc cross-compile test on shippable

----------------------------------------------------------------
Alex Bennée (1):
      .shippable.yml: disable powerpc-cross image

 .shippable.yml | 2 --
 1 file changed, 2 deletions(-)


-- 
2.15.1
