Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPDzB-0004vN-B5
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPDz9-0001Xa-CX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:55:09 -0500
Date: Tue, 20 Nov 2018 22:54:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181120215456.GF7513@localhost.localdomain>
References: <20181120172252.17800-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120172252.17800-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/2] iotests: More Python 3 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

Am 20.11.2018 um 18:22 hat Kevin Wolf geschrieben:
> Kevin Wolf (2):
>   iotests: Replace time.clock() with Timeout
>   iotests: Replace assertEquals() with assertEqual()

Thanks for the quick reviews, applied to the block branch.

Kevin
