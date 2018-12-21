Received: from eggs.gnu.org ([2001:4830:134:3::10]:53891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaQvd-00040Y-8W
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaQva-0002LJ-A1
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gaQva-0002JC-5R
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 21 Dec 2018 14:51:58 -0500
Message-Id: <20181221195200.6544-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/2] fp-bench fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Two small fixes for fp-bench. They fix the fact that we weren't
generating normals, even though we intended to.

You can pull this series from:
  https://github.com/cota/qemu/tree/fp-bench-fixes

Thanks,

		Emilio
