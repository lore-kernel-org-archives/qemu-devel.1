Received: from eggs.gnu.org ([2001:4830:134:3::10]:37932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1clLIq-0000rO-Ra
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 15:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1clLIn-0007Nj-PY
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 15:01:48 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit@kernel.org>) id 1clLIn-0007Ne-JA
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 15:01:45 -0500
Date: Tue, 7 Mar 2017 21:01:36 +0100
From: Amit Shah <amit@kernel.org>
Message-ID: <20170307200136.GJ25129@grmbl.mre>
References: <1488770972-322500-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488770972-322500-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-serial-bus: Delete timer from list
 before free it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On (Mon) 06 Mar 2017 [11:29:31], zhanghailiang wrote:
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Amit Shah <amit@kernel.org>

Michael, please pick this up.

		Amit
-- 
http://log.amitshah.net/
