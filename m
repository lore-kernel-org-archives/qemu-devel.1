Received: from eggs.gnu.org ([2001:4830:134:3::10]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clELb-0000ry-6P
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clELa-0005EL-HF
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:36:11 -0500
Date: Tue, 7 Mar 2017 13:36:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307123600.GJ5871@noname.str.redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] block: Op blocker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Am 06.03.2017 um 17:21 hat Kevin Wolf geschrieben:
> This series fixes a few problems introduced recently with the op blocker
> series. It includes mainly fix for cases where qemu would abort()
> instead of doing proper error handling previously. These changes also
> happen to result in more complete and correct permission checking.

Applied to the block branch.

Kevin
