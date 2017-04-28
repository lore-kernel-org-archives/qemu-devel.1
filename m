Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BOU-0001ka-PG
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BOS-0005o1-5k
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d4BOR-0005nm-VN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 28 Apr 2017 15:17:23 -0400
Message-Id: <1493407045-24172-1-git-send-email-cota@braap.org>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5+] TCG cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org

While at it, we might want to include these two for aarch64.

They apply on top Richard's tcg-next branch, which includes v5.

Thanks,

		Emilio
