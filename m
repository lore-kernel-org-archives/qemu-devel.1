Received: from eggs.gnu.org ([2001:4830:134:3::10]:42063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6GW7-00029i-B1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6GW6-00046e-Hv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:09:59 -0400
Date: Thu, 4 May 2017 15:09:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170504130947.GB5238@noname.redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v17 00/23] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

Am 02.05.2017 um 18:35 hat Fam Zheng geschrieben:
> v17: Fixes addressing comments by Kevin:
>      - Rebase on top of kevin/block
>      - In test case 153, don't compile test program, just try locking=on and
>        catch warning message
>      - Add a missing space in comment
>      - Error out if locking=on is used for file-win
>      - Add commit message and Cc qemu-stable for patch 17 (now 18)
>      - Don't add duplicated -U in the documentation

Thanks, applied to the block branch.

Kevin
