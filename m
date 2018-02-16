Received: from eggs.gnu.org ([2001:4830:134:3::10]:56206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emVMi-0004mo-EP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emVMf-0004ui-Cj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:03:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1emVMf-0004uW-5h
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:03:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 15 Feb 2018 21:02:48 -0500
Message-Id: <1518746572-14747-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/4] target/mips: translator loop conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Tested with Aurelien's debian wheezy image for mips64.

The third patch is just to improve the diff--saves about 20%
of diff lines in patch 4, but feel free to squash it with the latter.

Thanks,

		Emilio
