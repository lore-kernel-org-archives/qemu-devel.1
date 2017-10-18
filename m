Received: from eggs.gnu.org ([2001:4830:134:3::10]:34283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPX-0000Sp-EY
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPU-0003nP-0Q
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:01:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 18 Oct 2017 18:01:39 -0400
Message-Id: <1508364103-16131-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/4] Some trivial fixes, mostly comment typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

A few trivial fixes that I embedded in a previous (unrelated) patchset.
Better to submit them separately as a standalone "trivial" patchset.

Note that in patch 1 I went with space indentation instead of
a hard tab just to appease checkpatch. However, the surrounding
code uses hard tabs. Wasn't sure what's preferred in cases like
this.

Thanks,

		Emilio
