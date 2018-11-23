Received: from eggs.gnu.org ([2001:4830:134:3::10]:45570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKSr-0007h7-A3
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKSo-00029D-3o
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQKSn-000259-N0
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 23 Nov 2018 18:02:02 -0500
Message-Id: <20181123230206.12629-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/4] xxhash patches for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

(Plus a qht-bench trivial patch.)

Note that these apply on top of rth's tcg-next-for-4.0.

Thanks,

		Emilio
