Received: from eggs.gnu.org ([2001:4830:134:3::10]:43601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFkB-0003IX-HK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFk7-00072A-07
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fLFk6-00071X-Qm
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 May 2018 18:26:47 -0400
Message-Id: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/5] trace-mem fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This series fixes a few issues that I found while testing
the tracing of guest memory accesses in TCG. Please review!

You can fetch these patches from:
  https://github.com/cota/qemu/commits/trace-mem

Thanks,

		Emilio
