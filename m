Received: from eggs.gnu.org ([2001:4830:134:3::10]:45839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5YgS-0006Ii-W6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5YgS-00027X-8B
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:21:44 -0400
Date: Tue, 2 May 2017 16:21:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170502142128.GE5805@noname.redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
	<20170502081832.9546-18-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502081832.9546-18-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 17/22] block: Reuse bs as backing hd
 for drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 02.05.2017 um 10:18 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

Didn't you want to add an actual commit message and Cc: qemu-stable?

Kevin
