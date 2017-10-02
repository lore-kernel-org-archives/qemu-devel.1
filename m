Received: from eggs.gnu.org ([2001:4830:134:3::10]:57226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz24u-0002pz-U1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz24u-0003DW-5R
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:52:16 -0400
Date: Mon, 2 Oct 2017 16:52:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002145204.GD4362@localhost.localdomain>
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930195345.23338-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] qemu-io: Add -C for opening with
 copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Am 30.09.2017 um 21:53 hat Eric Blake geschrieben:
> Make it easier to enable copy-on-read during iotests, by
> exposing a new bool option to main and open.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
